


local doSqlFormat=function(sqlString)
    local handle=io.popen( "echo \""..sqlString.."\" | pg_format - -p '<><\\{(?:.*)?\\}'")
    if(handle==nil) then
        return sqlString
    end
    local result=handle:read("*a")
    handle:close();
    return result

end

local get_root=function(bufnr,filetype)
    local parser=vim.treesitter.get_parser(bufnr,filetype)
    local tree=parser:parse()[1]

    return tree:root()
end

local function lines(str)
  local result = {}
  for line in str:gmatch '[^\n]+' do
    table.insert(result, line)
  end
  return result

end

local remove_dollar=function(str)
    return string.gsub(str,'%$','<><')
end

local restore_dollar=function(str)

    return string.gsub(str,'<><','$')
end

local pos_within_range=function(pos,range)
    --print(vim.inspect(pos))
    --print(vim.inspect(range))
    if pos[1]<range[1]+1 or pos[1]>range[3]+1 then
        return false
    end

    return true

    --[[ if pos[1]>range[1]+1 and pos[1]<range[3]+1 then 
        return true
    end

    if pos[1]==range[1]+1 and pos[2]>=range[2]+1 then
        return true
    end

    if pos[1]==range[3]+1 and pos[2]<=range[4]+1 then
        return true
    end

    return false ]]
end

local run_format=function(pos,bufnr)
    pos=pos or nil
    bufnr=bufnr or vim.api.nvim_get_current_buf()

    local filetype=vim.bo.filetype

    if(filetype~='typescript' and filetype~='javascript') then
        return
    end

    local emb_suiteql=vim.treesitter.query.parse(filetype,'((template_string) @sql (#match? @sql "^`[^a-zA-z0-1]*([wW][iI][tT][hH]|[sS][eE][lL][eE][cC][tT]).*") (#offset! @sql 0 1 0 0))')
    local root=get_root(bufnr,filetype)

    local changes={}

    for id,node in emb_suiteql:iter_captures(root,bufnr,0,-1) do
        local name=emb_suiteql.captures[id]
        local range={node:range()}
        if name=='sql' and (pos==nil or pos_within_range(pos,range)) then
            local indent=string.rep(" ",range[2])
            local sql_text=vim.treesitter.get_node_text(node,bufnr)

            --remove template quotes from start and end
            --these break the formatter if left in
            local trimmed_text=string.sub(sql_text,2,string.len(sql_text)-1)
            --$ characters break the formatter, remove them
            trimmed_text=remove_dollar(trimmed_text)

            local formatted_text=doSqlFormat(trimmed_text)
            --resurround with template quotes
            formatted_text='`\n'..formatted_text..'\n`'
            --readd $ characters
            formatted_text=restore_dollar(formatted_text)


            --convert from string to table of lines
            local formatted_lines=lines(formatted_text)

            for idx,line in ipairs(formatted_lines) do
                if idx>1 then
                    formatted_lines[idx]=indent..line
                end
            end

            table.insert(changes,1,{start_row=range[1],start_col=range[2], end_row=range[3],end_col=range[4],formatted=formatted_lines})
        end
    end

    for _, change in ipairs(changes) do
        vim.api.nvim_buf_set_text(bufnr,change.start_row,change.start_col,change.end_row,change.end_col,change.formatted)
    end
end

vim.api.nvim_create_user_command("FormatSuiteQL",function()
    run_format()
end,{})

vim.api.nvim_create_user_command("FormatSingleSuiteQL",function()
    local pos=vim.api.nvim_win_get_cursor(0)
    run_format(pos)
end,{})

