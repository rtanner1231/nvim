
local File=require('user/custom/fileio')

local M={}

local resolve_typescript_file=function(tsfile,tspath)

    --todo cleanse tspath

    local ts_rem=string.gsub(tsfile,tspath,'')


    local res=File.pathcombine('/SuiteScripts/',ts_rem)

    --we should only be here if last two characters are ts
    local ret=string.sub(res,1,string.len(res)-2)..'js'

    return ret

end

local resolve_javascript_file=function(jsfile)
    local ind=string.find(jsfile,'/SuiteScripts')

    if ind==nil then
        return nil
    end

    return string.sub(jsfile,ind,string.len(jsfile))
end

local get_relative_paths=function(files)
    local cwd=vim.fn.getcwd()

    local ret={}

    for _,v in pairs(files) do
        local rel=string.gsub(v,cwd,'')
        table.insert(ret,rel)
    end

    return ret
end



local get_final_paths=function(relpaths,opts)
    local final_paths={}
    local is_typescript=false

    for _,v in pairs(relpaths) do
        local name=v
        local ext=File.getFileExt(name)

        if ext=='.js' or ext=='.ts' then

            if ext=='.ts' and opts.typescript_path~=nil then
                name=resolve_typescript_file(name,opts.typescript_path)
                is_typescript=true
            elseif ext=='.js' then
                name=resolve_javascript_file(name)
            else
                name=nil
            end

            if name~=nil then
                table.insert(final_paths,name)
            end
        end
    end

    return final_paths,is_typescript
end

local function string_to_table(str)
  local result = {}
  for line in str:gmatch '[^\n]+' do
    table.insert(result, line)
  end
  return result

end

local get_git_command_file_list=function(command,opts)
    
    local handle=io.popen(command)
    if(handle==nil) then
        return
    end
    local result=handle:read("*a")
    
    local result_lines=string_to_table(result)

    local normalized_lines={}

    for _,v in pairs(result_lines) do
        table.insert(normalized_lines,'/'..v)
    end

    local final_paths,is_typescript=get_final_paths(normalized_lines,opts)

    
    return final_paths,is_typescript
end


local get_file_list_from_files=function(files,opts)
    local rel_paths=get_relative_paths(files)

    local final_paths,is_typescript=get_final_paths(rel_paths,opts)
    
    return final_paths,is_typescript

end

--opts: {typescript_path:string}
M.get_dir_file_list=function(opts)

    local full_path=vim.api.nvim_buf_get_name(0)

    local dir=File.getDirFromPath(full_path)

    local dir_files=File.getDirFiles(dir)

    return get_file_list_from_files(dir_files,opts)

end

M.get_single_file_list=function(opts)

    local full_path=vim.api.nvim_buf_get_name(0)

    return get_file_list_from_files({full_path},opts)
end

M.get_last_commit_changes=function(opts)
    return get_git_command_file_list('git diff --name-only HEAD~1',opts)
end

M.get_unstaged_file_list=function(opts)
    return get_git_command_file_list('git diff --name-only',opts)
end

M.get_staged_file_list=function(opts)
    return get_git_command_file_list('git diff --name-only --staged',opts)
end


M.get_command_from_files=function(files)
    local param=''

    for _,v in pairs(files) do
        if string.len(param)>0 then
            param=param..' '
        end

        param=param..'"'..v..'"'
    end

    return 'suitecloud file:upload --paths '..param
end

return M
