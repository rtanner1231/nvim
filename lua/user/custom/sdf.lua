local Dialog=require('user/custom/dialog')
local File=require('user/custom/fileio')
local SDFFileDeploy=require('user/custom/sdffiledeploy')

local read_file = function(path)
    local content=''
    local file=io.open(path,'r')

    if file then
        content=file:read('*a')
        file:close()
    end
    return content
end

local file_exists=function(file_path)
    local f=io.open(file_path,'r')

    if f~=nil then
        io.close(f)
        return true
    else
        return false
    end
end

local write_file=function(file_path,contents)
    local f=io.open(file_path,'w')
    if f then
        f:write(contents)
        f:close()
    end
end

local projects_file_path=function()
    local cwd=vim.fn.getcwd()
    return cwd..'/project.json'
end

local suitecloudaccount =function()
    local file_path=projects_file_path()
    local data=read_file(file_path)
    --print(data);
    --local file_lines=lines(data)
    local _,_,c=string.find(data,'"defaultAuthId":%s*"(.*)"')

  --return [[hello world]]
    if c==nil then
        return ''
    else
        return c
    end
end

local is_sdf_project=function()

    local project_path=projects_file_path()
    if file_exists(project_path)==true then
        return true
    else 
        return false
    end
end

local send_to_terminal=function(command)
    local full_command="TermExec cmd='"..command.."'"
    vim.cmd(full_command)
end

local deploy_project=function()
    
    local sdf_account=suitecloudaccount()

    local message={sdf_account,"Are you sure you want to deploy?"}

    Dialog.confirm(message,function()
        send_to_terminal('suitecloud project:deploy')
    end)



end


local set_sdf_account=function(sdf_account)
    local contents='{\n "defaultAuthId": "'..sdf_account..'" \n}'
    local project_path=projects_file_path()
    write_file(project_path,contents)
end

local function string_to_table(str)
  local result = {}
  for line in str:gmatch '[^\n]+' do
    table.insert(result, line)
  end
  return result

end


local get_sdf_accounts=function()
    
    local handle=io.popen("suitecloud account:manageauth --list")
    if(handle==nil) then
        return
    end
    local result=handle:read("*a")
    --change this regex when I figure out how to repeat .{7} doesn't work
    local accounts=result:match("^........(.*)")
    local account_lines=string_to_table(accounts)
    
    local account_table={}

    for _,v in pairs(account_lines) do
        local val=v:match("^([^|]+) |")
        table.insert(account_table,{option_text=v,value=val})
    end


    return account_table
end

local run_typescript_pre=function()
    io.popen('npm run build')
end

local deploy_files=function(file_list,is_typescript)
    
    if #file_list==0 then
        Dialog.alert({'No files to deploy'})
        return
    end

    local sdf_account=suitecloudaccount()
    local confirm_message={sdf_account,"Deploy the following files?"}

    for _,v in pairs(file_list) do
        table.insert(confirm_message,v)
    end

    Dialog.confirm(confirm_message,function()
        local command=SDFFileDeploy.get_command_from_files(file_list)

        if is_typescript then
            command='npm run build && '..command
        end

        send_to_terminal(command)
    end)
end

--------------------------------------------------------------------------------Entry functions


local deploy=function()

    deploy_project()
end

local select_account=function()

    local accounts=get_sdf_accounts()
    -- local account_options={
    --     {option_text="SB1",value="SB1"},
    --     {option_text="UAT",value="UAT"},
    --     {option_text="PROD",value="PROD"}
    -- }
    Dialog.option('Select SDF Account',accounts,set_sdf_account)
end

local get_opts=function()
    return {typescript_path='/TypeScripts/'}
end

local deploy_dir=function()
    local files,is_typescript=SDFFileDeploy.get_dir_file_list(get_opts())

    deploy_files(files,is_typescript)

end

local deploy_file=function()

    local files,is_typescript=SDFFileDeploy.get_single_file_list(get_opts())

    deploy_files(files,is_typescript)
end

local deploy_git_last_commit=function()
    local files,is_typescript=SDFFileDeploy.get_last_commit_changes(get_opts())

    deploy_files(files,is_typescript)
end

local deploy_git_unstaged=function()
    local files,is_typescript=SDFFileDeploy.get_unstaged_file_list(get_opts())
    
    deploy_files(files,is_typescript)
end

local deploy_git_staged=function()
    local files,is_typescript=SDFFileDeploy.get_staged_file_list(get_opts())
    
    deploy_files(files,is_typescript)
end

local run_command,show_function_menu

local command_list={
    {option_text="Menu", value="Menu"},
    {option_text="Deploy",value="Deploy", callback=deploy},
    {option_text="Deploy Current Folder",value="DeployCurrentFolder",callback=deploy_dir},
    {option_text="Deploy Current File",value="DeployCurrentFile",callback=deploy_file},
    {option_text="Deploy Changes Since Last Commit", value="GitDeployLastCommit",callback=deploy_git_last_commit},
    {option_text="Deploy Unstaged changes",value="GitDeployUnstaged",callback=deploy_git_unstaged},
    {option_text="Deploy Staged Changes",value="GitDeployStaged",callback=deploy_git_staged},
    {option_text="Select Account",value="SelectAccount",callback=select_account},
}

function run_command(command)
    if command=='Menu' then
        show_function_menu()
        return
    end
    -- elseif command=='Deploy' then
    --     deploy()
    -- elseif command=='DeployCurrentFolder' then
    --     deploy_dir()
    -- elseif command=='DeployCurrentFile' then
    --     deploy_file()
    -- elseif command=='SelectAccount' then
    --     select_account()
    -- elseif command=='GitLastCommit' then
    --     deploy_git_last_commit()
    -- end

    for _,v in pairs(command_list) do
        if v.value==command then
            v.callback()
            return
        end
    end
end

function show_function_menu()
    local menu_list={}
    for _,v in pairs(command_list) do
        if v.value~='Menu' then
            table.insert(menu_list,v)
        end
    end


    Dialog.option('Select Command',menu_list,run_command)
end


-- vim.api.nvim_create_user_command("SDFDeploy",function()
--
--     if not is_sdf_project() then
--         return
--     end
--
--     deploy_project()
-- end,{})
--
--
-- vim.api.nvim_create_user_command("SDFSelectAccount",function()
--
--     
--     if not is_sdf_project() then
--         return
--     end
--
--     local accounts=get_sdf_accounts()
--     -- local account_options={
--     --     {option_text="SB1",value="SB1"},
--     --     {option_text="UAT",value="UAT"},
--     --     {option_text="PROD",value="PROD"}
--     -- }
--     Dialog.option('Select SDF Account',accounts,set_sdf_account)
-- end,{})
--
-- vim.api.nvim_create_user_command("SDFDeployDir",function()
--
--     if not is_sdf_project() then
--         return
--     end
--
--     local files,is_typescript=SDFFileDeploy.get_dir_file_list({typescript_path='/TypeScripts/'})
--
--     deploy_files(files,is_typescript)
--     
-- end,{})
--
-- vim.api.nvim_create_user_command("SDFDeployFile",function()
--
--     if not is_sdf_project() then
--         return
--     end
--
--     local files,is_typescript=SDFFileDeploy.get_single_file_list({typescript_path='/TypeScripts/'})
--
--     deploy_files(files,is_typescript)
--     
-- end,{})

vim.api.nvim_create_user_command("SDF",function(opts)
   if #opts.fargs==0 then
    print('no args')
    return
   end

    if not is_sdf_project() then
        return
    end


    run_command(opts.args)

end,{
        nargs=1,
        complete=function(_,_,_)
            local cList={}
            for _,v in pairs(command_list) do
                table.insert(cList,v.value)
            end
            return cList
        end

    })
