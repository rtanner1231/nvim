
local M={}

local function get_type_from(type_, cwd)
  return type_ or (vim.loop.fs_stat(cwd) or {}).type
end

local table_length=function(tbl)
    local count=0
    for _ in pairs(tbl) do
        count=count+1
    end
    return count

end

M.pathcombine=function(path1,path2)
    local last1=string.sub(path1,-1)
    if last1=='/' then
        path1=string.sub(path1,1,string.len(path1)-1)
    end

    local first2=string.sub(path2,1,1)
    if first2=='/' then
        path2=string.sub(path2,2,string.len(path2))
    end

    return path1..'/'..path2
end

M.getFileExt=function(filename)
  return filename:match("^.+(%..+)$")
end

M.getDirFromPath=function(full_path)
    local path_tokens={}
  for token in full_path:gmatch '[^/]+' do
    table.insert(path_tokens, token)
  end

    local len=table_length(path_tokens)

    table.remove(path_tokens,len)

    local ret=''

    for _,v in pairs(path_tokens) do
        ret=ret..'/'..v
    end

    return ret

end


M.scandir=function(path)
    local handle=vim.loop.fs_scandir(path)

    local ret={}

    while true do
        
        local name, t = vim.loop.fs_scandir_next(handle)
        if not name then
          break
        end

        local fullname=M.pathcombine(path,name)

        table.insert(ret,{name=fullname,type=t})
    end

    return ret
end

M.getDirFiles=function(full_path)
    local all_files=M.scandir(full_path)

    local ret={}

    for _,v in pairs(all_files) do
        if v.type=="file" then
            table.insert(ret,v.name)
        end
    end

    return ret;
end

return M
