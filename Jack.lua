--[[ 
████████╗░██╗░░░░░░░██╗██╗██╗░░██╗
╚══██╔══╝░██║░░██╗░░██║██║╚██╗██╔╝
░░░██║░░░░╚██╗████╗██╔╝██║░╚███╔╝░
░░░██║░░░░░████╔═████║░██║░██╔██╗░
░░░██║░░░░░╚██╔╝░╚██╔╝░██║██╔╝╚██╗
░░░╚═╝░░░░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝
--]]
URL     = require("./libs/url")
JSON    = require("./libs/dkjson")
serpent = require("libs/serpent")
json = require('libs/json')
redis = require('libs/redis').connect('127.0.0.1', 6379)
http  = require("socket.http")
https   = require("ssl.https")
local Methods = io.open("./luatele.lua","r")
if Methods then
URL.tdlua_CallBack()
end
SshId = io.popen("echo $SSH_CLIENT ︙ awk '{ print $1}'"):read('*a')
luatele = require 'luatele'
local FileInformation = io.open("./Information.lua","r")
if not FileInformation then
if not redis:get(SshId.."Info:redis:Token") then
io.write('\27[1;31mارسل لي توكن البوت الان \nSend Me a Bot Token Now ↡\n\27[0;39;49m')
local TokenBot = io.read()
if TokenBot and TokenBot:match('(%d+):(.*)') then
local url , res = https.request('https://api.telegram.org/bot'..TokenBot..'/getMe')
local Json_Info = JSON.decode(url)
if res ~= 200 then
print('\27[1;34mعذرا توكن البوت خطأ تحقق منه وارسله مره اخرى \nBot Token is Wrong\n')
else
io.write('\27[1;34mتم حفظ التوكن بنجاح \nThe token been saved successfully \n\27[0;39;49m')
TheTokenBot = TokenBot:match("(%d+)")
os.execute('sudo rm -fr .CallBack-Bot/'..TheTokenBot)
redis:set(SshId.."Info:redis:Token",TokenBot)
redis:set(SshId.."Info:redis:Token:User",Json_Info.result.username)
end 
else
print('\27[1;34mلم يتم حفظ التوكن جرب مره اخرى \nToken not saved, try again')
end 
os.execute('lua Jack.lua')
end
if not redis:get(SshId.."Info:redis:User") then
io.write('\27[1;31mارسل معرف المطور الاساسي الان \nDeveloper UserName saved ↡\n\27[0;39;49m')
local UserSudo = io.read():gsub('@','')
if UserSudo ~= '' then
io.write('\n\27[1;34mتم حفظ معرف المطور \nDeveloper UserName saved \n\n\27[0;39;49m')
redis:set(SshId.."Info:redis:User",UserSudo)
else
print('\n\27[1;34mلم يتم حفظ معرف المطور الاساسي \nDeveloper UserName not saved\n')
end 
os.execute('lua Jack.lua')
end
if not redis:get(SshId.."Info:redis:User:ID") then
io.write('\27[1;31mارسل ايدي المطور الاساسي الان \nDeveloper ID saved ↡\n\27[0;39;49m')
local UserId = io.read()
if UserId and UserId:match('(%d+)') then
io.write('\n\27[1;34mتم حفظ ايدي المطور \nDeveloper ID saved \n\n\27[0;39;49m')
redis:set(SshId.."Info:redis:User:ID",UserId)
else
print('\n\27[1;34mلم يتم حفظ ايدي المطور الاساسي \nDeveloper ID not saved\n')
end 
os.execute('lua Jack.lua')
end
local Informationlua = io.open("Information.lua", 'w')
Informationlua:write([[
return {
Token = "]]..redis:get(SshId.."Info:redis:Token")..[[",
UserBot = "]]..redis:get(SshId.."Info:redis:Token:User")..[[",
UserSudo = "]]..redis:get(SshId.."Info:redis:User")..[[",
SudoId = ]]..redis:get(SshId.."Info:redis:User:ID")..[[
}
]])
Informationlua:close()
local Jack = io.open("Jack", 'w')
Jack:write([[
cd $(cd $(dirname $0); pwd)
while(true) do
sudo lua5.3 Jack.lua
done
]])
Jack:close()
local Run = io.open("Run", 'w')
Run:write([[
cd $(cd $(dirname $0); pwd)
while(true) do
screen -S Jack -X kill
screen -S Jack ./Jack
done
]])
Run:close()
redis:del(SshId.."Info:redis:User:ID");redis:del(SshId.."Info:redis:User");redis:del(SshId.."Info:redis:Token:User");redis:del(SshId.."Info:redis:Token")
os.execute('chmod +x Jack;chmod +x Run;./Run')
end
Information = dofile('./Information.lua')
Sudo_Id = Information.SudoId
UserSudo = Information.UserSudo
Token = Information.Token
UserBot = Information.UserBot
Jack = Token:match("(%d+)")
os.execute('sudo rm -fr .CallBack-Bot/'..Jack)
LuaTele = luatele.set_config{api_id=2692371,api_hash='fe85fff033dfe0f328aeb02b4f784930',session_name=Jack,token=Token}
function var(value)  
print(serpent.block(value, {comment=false}))   
end 



function chat_type(ChatId)
if ChatId then
local id = tostring(ChatId)
if id:match("-100(%d+)") then
Chat_Type = 'GroupBot' 
elseif id:match("^(%d+)") then
Chat_Type = 'UserBot' 
else
Chat_Type = 'GroupBot' 
end
end
return Chat_Type
end
function The_ControllerAll(UserId)
ControllerAll = false
local ListSudos ={Sudo_Id,332581832}  
for k, v in pairs(ListSudos) do
if tonumber(UserId) == tonumber(v) then
ControllerAll = true
end
end
return ControllerAll
end
function Controller(ChatId,UserId)
Status = 0
Developers = redis:sismember(Jack.."Jack:Developers:Groups",UserId) 
TheBasics = redis:sismember(Jack..":MONSHA_Groupp:"..ChatId,UserId) 
TheBasicsQ = redis:sismember(Jack..":MONSHA_Group:"..ChatId,UserId) 
Originators = redis:sismember(Jack.."Jack:Originators:Group"..ChatId,UserId)
Managers = redis:sismember(Jack.."Jack:Managers:Group"..ChatId,UserId)
Addictive = redis:sismember(Jack.."Jack:Addictive:Group"..ChatId,UserId)
Distinguished = redis:sismember(Jack.."Jack:Distinguished:Group"..ChatId,UserId)
StatusMember = LuaTele.getChatMember(ChatId,UserId).status.luatele
if UserId == 100200300 then
Status = 'Aec🎖'
elseif UserId == Sudo_Id then  
Status = 'Dev🎖'
elseif UserId == Jack then
Status = 'البوت'
elseif Developers then
Status = redis:get(Jack.."Jack:Developer:Bot:Reply"..ChatId) or ' Myth 🎖'
elseif TheBasicsQ then
Status = redis:get(Jack.."Jack:PresidentQ:Group:Reply"..ChatId) or 'المالك'
elseif TheBasics then
Status = redis:get(Jack.."Jack:President:Group:Reply"..ChatId) or 'المنشئ الاساسي'
elseif Originators then
Status = redis:get(Jack.."Jack:Constructor:Group:Reply"..ChatId) or 'المنشئ'
elseif Managers then
Status = redis:get(Jack.."Jack:Manager:Group:Reply"..ChatId) or 'المدير'
elseif Addictive then
Status = redis:get(Jack.."Jack:Admin:Group:Reply"..ChatId) or 'الادمن'
elseif StatusMember == "chatMemberStatusCreator" then
Status = 'مالك المجموعه'
elseif StatusMember == "chatMemberStatusAdministrator" then
Status = 'ادمن المجموعه'
elseif Distinguished then
Status = redis:get(Jack.."Jack:Vip:Group:Reply"..ChatId) or 'المميز'
else
Status = redis:get(Jack.."Jack:Mempar:Group:Reply"..ChatId) or 'العضو'
end  
return Status
end 
function Controller_Num(Num)
Status = 0
if tonumber(Num) == 1 then  
Status = 'Dev🎖'
elseif tonumber(Num) == 2 then  
Status = ' Dev² 🎖'
elseif tonumber(Num) == 3 then  
Status = ' Myth 🎖'
elseif tonumber(Num) == 44 then  
Status = 'المالك'
elseif tonumber(Num) == 4 then  
Status = 'المنشئ الاساسي'
elseif tonumber(Num) == 5 then  
Status = 'المنشئ'
elseif tonumber(Num) == 6 then  
Status = 'المدير'
elseif tonumber(Num) == 7 then  
Status = 'الادمن'
else
Status = 'المميز'
end  
return Status
end 
function Flter_Markdown(TextMsg) 
local Text = tostring(TextMsg)
Text = Text:gsub('_',[[\_]])
Text = Text:gsub('*','\\*')
Text = Text:gsub('`','\\`')
local Hyperlink = Text:match('[(](.*)[)]')
local Hyperlink1 = Text:match('[[](.*)[]]')
if Hyperlink and Hyperlink1 then
Hyperlink = "("..Hyperlink:gsub([[\_]],'_')..")"
Text = Text:gsub('[(](.*)[)]',Hyperlink ) 
Hyperlink1 = Hyperlink1:gsub([[\_]],'_')
Hyperlink1 = "["..Hyperlink1:gsub('[[][]]','').."]"
Text = Text:gsub('[[](.*)[]]',Hyperlink1 ) 
end
return Text 
end
function RandomText()
local Cominnt = {
'للاسف ايديك تلوث بصري ): .',
"حرفياً الجبر شوفة ايديه 🤍.",
"جبر لقلبي قبل قلوبهم 💛.",
"يع لا تكتب ايدي مرا ثانيه .",
"الواحد يتمنى انه افتار لك 🥺.",
}
return Cominnt[math.random(#Cominnt)] 
end
function convert_Klmat(msg,data,Replay,MD)
local Status_Gps = msg.TheRankCmd
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local Emsgs = redis:get(Jack..'msgs:'..msg.sender.user_id..':'..msg.chat_id) or 1
local TotalMsg = Total_message(Emsgs)
local edited = redis:get(Jack..'Jack:Num:Message:Edit'..msg.chat_id..msg.sender.user_id) or 0
local points = redis:get(Jack.."Jack:Num:Add:Games"..msg.chat_id..msg.sender.user_id) or 0
local infouser = https.request("https://api.telegram.org/bot"..Token.."/getChat?chat_id="..msg.sender.user_id)
local info_ = JSON.decode(infouser)
if info_.result.bio then
biouser = info_.result.bio
else
biouser = 'لا يوجد '
end
local Ctitle = https.request("https://api.telegram.org/bot"..Token.."/getChatMember?chat_id="..msg.chat_id.."&user_id="..msg.sender.user_id)
local info_ = JSON.decode(Ctitle)
if info_.result.status == "administrator" and info_.result.custom_title or info_.result.status == "creator" and info_.result.custom_title then
lakbk = info_.result.custom_title
else
lakbk = 'لا يوجد'
end
if Replay then
Replay = Replay:gsub("#الاسم",UserInfo.first_name)
Replay = Replay:gsub("#الايدي",msg.sender.user_id)
Replay = Replay:gsub("#اليوزر",(UserInfo.username or 'لا يوجد'))
Replay = Replay:gsub("#الرتبه",Status_Gps)
Replay = Replay:gsub("#التفاعل",TotalMsg)
Replay = Replay:gsub("#الرسائل",Emsgs)
Replay = Replay:gsub("#التعديل",edited)
Replay = Replay:gsub("#اللقب",lakbk)
Replay = Replay:gsub('#البايو',biouser)
Replay = Replay:gsub("#النقاط",points)
Replay = Replay:gsub("#التعليقات",RandomText())
else
Replay =""
end
if MD then
return Replay
else
return Replay
end
end

function GetAdminsSlahe(ChatId,UserId,user2,MsgId,t1,t2,t3,t4,t5,t6)
local GetMemberStatus = LuaTele.getChatMember(ChatId,user2).status
if GetMemberStatus.can_change_info then
change_info = '〖  نعم 〗' else change_info = '〖  لا 〗'
end
if GetMemberStatus.can_delete_messages then
delete_messages = '〖  نعم 〗' else delete_messages = '〖  لا 〗'
end
if GetMemberStatus.can_invite_users then
invite_users = '〖  نعم 〗' else invite_users = '〖  لا 〗'
end
if GetMemberStatus.can_pin_messages then
pin_messages = '〖  نعم 〗' else pin_messages = '〖  لا 〗'
end
if GetMemberStatus.can_restrict_members then
restrict_members = '〖  نعم 〗' else restrict_members = '〖  لا 〗'
end
if GetMemberStatus.can_promote_members then
promote = '〖  نعم 〗' else promote = '〖  لا 〗'
end
local reply_markupp = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- تغيير معلومات المجموعه : '..(t1 or change_info), data = UserId..'/groupNum1//'..user2}, 
},
{
{text = '- تثبيت الرسائل : '..(t2 or pin_messages), data = UserId..'/groupNum2//'..user2}, 
},
{
{text = '- حظر المستخدمين : '..(t3 or restrict_members), data = UserId..'/groupNum3//'..user2}, 
},
{
{text = '- دعوة المستخدمين : '..(t4 or invite_users), data = UserId..'/groupNum4//'..user2}, 
},
{
{text = '- حذف الرسائل : '..(t5 or delete_messages), data = UserId..'/groupNum5//'..user2}, 
},
{
{text = '- اضافة مشرفين : '..(t6 or promote), data = UserId..'/groupNum6//'..user2}, 
},
}
}
LuaTele.editMessageText(ChatId,MsgId,"•  صلاحيات الادمن - ", "md", false, false, reply_markupp)
end
function GetAdminsNum(ChatId,UserId)
local GetMemberStatus = LuaTele.getChatMember(ChatId,UserId).status
if GetMemberStatus.can_change_info then
change_info = 1 else change_info = 0
end
if GetMemberStatus.can_delete_messages then
delete_messages = 1 else delete_messages = 0
end
if GetMemberStatus.can_invite_users then
invite_users = 1 else invite_users = 0
end
if GetMemberStatus.can_pin_messages then
pin_messages = 1 else pin_messages = 0
end
if GetMemberStatus.can_restrict_members then
restrict_members = 1 else restrict_members = 0
end
if GetMemberStatus.can_promote_members then
promote = 1 else promote = 0
end
return{
promote = promote,
restrict_members = restrict_members,
invite_users = invite_users,
pin_messages = pin_messages,
delete_messages = delete_messages,
change_info = change_info
}
end
function GetSetieng(ChatId)
if redis:get(Jack.."Jack:lockpin"..ChatId) then    
lock_pin = "نعم"
else 
lock_pin = "لا"    
end
if redis:get(Jack.."Jack:Lock:tagservr"..ChatId) then    
lock_tagservr = "نعم"
else 
lock_tagservr = "لا"
end
if redis:get(Jack.."Jack:Lock:text"..ChatId) then    
lock_text = "نعم"
else 
lock_text = "لا "    
end
if redis:get(Jack.."Jack:Lock:AddMempar"..ChatId) == "kick" then
lock_add = "نعم"
else 
lock_add = "لا "    
end    
if redis:get(Jack.."Jack:Lock:Join"..ChatId) == "kick" then
lock_join = "نعم"
else 
lock_join = "لا "    
end    
if redis:get(Jack.."Jack:Lock:edit"..ChatId) then    
lock_edit = "نعم"
else 
lock_edit = "لا "    
end
if redis:get(Jack.."Jack:Chek:Welcome"..ChatId) then
welcome = "نعم"
else 
welcome = "لا "    
end
if redis:hget(Jack.."Jack:Spam:Group:User"..ChatId, "Spam:User") == "kick" then     
flood = "بالطرد "     
elseif redis:hget(Jack.."Jack:Spam:Group:User"..ChatId,"Spam:User") == "keed" then     
flood = "بالتقيد "     
elseif redis:hget(Jack.."Jack:Spam:Group:User"..ChatId,"Spam:User") == "mute" then     
flood = "بالكتم "           
elseif redis:hget(Jack.."Jack:Spam:Group:User"..ChatId,"Spam:User") == "del" then     
flood = "نعم"
else     
flood = "لا "     
end
if redis:get(Jack.."Jack:Lock:Photo"..ChatId) == "del" then
lock_photo = "نعم" 
elseif redis:get(Jack.."Jack:Lock:Photo"..ChatId) == "ked" then 
lock_photo = "بالتقيد "   
elseif redis:get(Jack.."Jack:Lock:Photo"..ChatId) == "ktm" then 
lock_photo = "بالكتم "    
elseif redis:get(Jack.."Jack:Lock:Photo"..ChatId) == "kick" then 
lock_photo = "بالطرد "   
else
lock_photo = "لا "   
end    
if redis:get(Jack.."Jack:Lock:Contact"..ChatId) == "del" then
lock_phon = "نعم" 
elseif redis:get(Jack.."Jack:Lock:Contact"..ChatId) == "ked" then 
lock_phon = "بالتقيد "    
elseif redis:get(Jack.."Jack:Lock:Contact"..ChatId) == "ktm" then 
lock_phon = "بالكتم "    
elseif redis:get(Jack.."Jack:Lock:Contact"..ChatId) == "kick" then 
lock_phon = "بالطرد "    
else
lock_phon = "لا "    
end    
if redis:get(Jack.."Jack:Lock:Link"..ChatId) == "del" then
lock_links = "نعم"
elseif redis:get(Jack.."Jack:Lock:Link"..ChatId) == "ked" then
lock_links = "بالتقيد "    
elseif redis:get(Jack.."Jack:Lock:Link"..ChatId) == "ktm" then
lock_links = "بالكتم "    
elseif redis:get(Jack.."Jack:Lock:Link"..ChatId) == "kick" then
lock_links = "بالطرد "    
else
lock_links = "لا "    
end
if redis:get(Jack.."Jack:Lock:Cmd"..ChatId) == "del" then
lock_cmds = "نعم"
elseif redis:get(Jack.."Jack:Lock:Cmd"..ChatId) == "ked" then
lock_cmds = "بالتقيد "    
elseif redis:get(Jack.."Jack:Lock:Cmd"..ChatId) == "ktm" then
lock_cmds = "بالكتم "   
elseif redis:get(Jack.."Jack:Lock:Cmd"..ChatId) == "kick" then
lock_cmds = "بالطرد "    
else
lock_cmds = "لا "    
end
if redis:get(Jack.."Jack:Lock:User:Name"..ChatId) == "del" then
lock_user = "نعم"
elseif redis:get(Jack.."Jack:Lock:User:Name"..ChatId) == "ked" then
lock_user = "بالتقيد "    
elseif redis:get(Jack.."Jack:Lock:User:Name"..ChatId) == "ktm" then
lock_user = "بالكتم "    
elseif redis:get(Jack.."Jack:Lock:User:Name"..ChatId) == "kick" then
lock_user = "بالطرد "    
else
lock_user = "لا "    
end
if redis:get(Jack.."Jack:Lock:hashtak"..ChatId) == "del" then
lock_hash = "نعم"
elseif redis:get(Jack.."Jack:Lock:hashtak"..ChatId) == "ked" then 
lock_hash = "بالتقيد "    
elseif redis:get(Jack.."Jack:Lock:hashtak"..ChatId) == "ktm" then 
lock_hash = "بالكتم "    
elseif redis:get(Jack.."Jack:Lock:hashtak"..ChatId) == "kick" then 
lock_hash = "بالطرد "    
else
lock_hash = "لا "    
end
if redis:get(Jack.."Jack:Lock:vico"..ChatId) == "del" then
lock_muse = "نعم"
elseif redis:get(Jack.."Jack:Lock:vico"..ChatId) == "ked" then 
lock_muse = "بالتقيد "    
elseif redis:get(Jack.."Jack:Lock:vico"..ChatId) == "ktm" then 
lock_muse = "بالكتم "    
elseif redis:get(Jack.."Jack:Lock:vico"..ChatId) == "kick" then 
lock_muse = "بالطرد "    
else
lock_muse = "لا "    
end 
if redis:get(Jack.."Jack:Lock:Video"..ChatId) == "del" then
lock_ved = "نعم"
elseif redis:get(Jack.."Jack:Lock:Video"..ChatId) == "ked" then 
lock_ved = "بالتقيد "    
elseif redis:get(Jack.."Jack:Lock:Video"..ChatId) == "ktm" then 
lock_ved = "بالكتم "    
elseif redis:get(Jack.."Jack:Lock:Video"..ChatId) == "kick" then 
lock_ved = "بالطرد "    
else
lock_ved = "لا "    
end
if redis:get(Jack.."Jack:Lock:Animation"..ChatId) == "del" then
lock_gif = "نعم"
elseif redis:get(Jack.."Jack:Lock:Animation"..ChatId) == "ked" then 
lock_gif = "بالتقيد "    
elseif redis:get(Jack.."Jack:Lock:Animation"..ChatId) == "ktm" then 
lock_gif = "بالكتم "    
elseif redis:get(Jack.."Jack:Lock:Animation"..ChatId) == "kick" then 
lock_gif = "بالطرد "    
else
lock_gif = "لا "    
end
if redis:get(Jack.."Jack:Lock:Sticker"..ChatId) == "del" then
lock_ste = "نعم"
elseif redis:get(Jack.."Jack:Lock:Sticker"..ChatId) == "ked" then 
lock_ste = "بالتقيد "    
elseif redis:get(Jack.."Jack:Lock:Sticker"..ChatId) == "ktm" then 
lock_ste = "بالكتم "    
elseif redis:get(Jack.."Jack:Lock:Sticker"..ChatId) == "kick" then 
lock_ste = "بالطرد "    
else
lock_ste = "لا "    
end
if redis:get(Jack.."Jack:Lock:geam"..ChatId) == "del" then
lock_geam = "نعم"
elseif redis:get(Jack.."Jack:Lock:geam"..ChatId) == "ked" then 
lock_geam = "بالتقيد "    
elseif redis:get(Jack.."Jack:Lock:geam"..ChatId) == "ktm" then 
lock_geam = "بالكتم "    
elseif redis:get(Jack.."Jack:Lock:geam"..ChatId) == "kick" then 
lock_geam = "بالطرد "    
else
lock_geam = "لا "    
end    
if redis:get(Jack.."Jack:Lock:vico"..ChatId) == "del" then
lock_vico = "نعم"
elseif redis:get(Jack.."Jack:Lock:vico"..ChatId) == "ked" then 
lock_vico = "بالتقيد "    
elseif redis:get(Jack.."Jack:Lock:vico"..ChatId) == "ktm" then 
lock_vico = "بالكتم "    
elseif redis:get(Jack.."Jack:Lock:vico"..ChatId) == "kick" then 
lock_vico = "بالطرد "    
else
lock_vico = "لا "    
end    
if redis:get(Jack.."Jack:Lock:Keyboard"..ChatId) == "del" then
lock_inlin = "نعم"
elseif redis:get(Jack.."Jack:Lock:Keyboard"..ChatId) == "ked" then 
lock_inlin = "بالتقيد "
elseif redis:get(Jack.."Jack:Lock:Keyboard"..ChatId) == "ktm" then 
lock_inlin = "بالكتم "    
elseif redis:get(Jack.."Jack:Lock:Keyboard"..ChatId) == "kick" then 
lock_inlin = "بالطرد "
else
lock_inlin = "لا "
end
if redis:get(Jack.."Jack:Lock:forward"..ChatId) == "del" then
lock_fwd = "نعم"
elseif redis:get(Jack.."Jack:Lock:forward"..ChatId) == "ked" then 
lock_fwd = "بالتقيد "    
elseif redis:get(Jack.."Jack:Lock:forward"..ChatId) == "ktm" then 
lock_fwd = "بالكتم "    
elseif redis:get(Jack.."Jack:Lock:forward"..ChatId) == "kick" then 
lock_fwd = "بالطرد "    
else
lock_fwd = "لا "    
end    
if redis:get(Jack.."Jack:Lock:Document"..ChatId) == "del" then
lock_file = "نعم"
elseif redis:get(Jack.."Jack:Lock:Document"..ChatId) == "ked" then 
lock_file = "بالتقيد "    
elseif redis:get(Jack.."Jack:Lock:Document"..ChatId) == "ktm" then 
lock_file = "بالكتم "    
elseif redis:get(Jack.."Jack:Lock:Document"..ChatId) == "kick" then 
lock_file = "بالطرد "    
else
lock_file = "لا "    
end    
if redis:get(Jack.."Jack:Lock:Unsupported"..ChatId) == "del" then
lock_self = "نعم"
elseif redis:get(Jack.."Jack:Lock:Unsupported"..ChatId) == "ked" then 
lock_self = "بالتقيد "    
elseif redis:get(Jack.."Jack:Lock:Unsupported"..ChatId) == "ktm" then 
lock_self = "بالكتم "    
elseif redis:get(Jack.."Jack:Lock:Unsupported"..ChatId) == "kick" then 
lock_self = "بالطرد "    
else
lock_self = "لا "    
end
if redis:get(Jack.."Jack:Lock:Bot:kick"..ChatId) == "del" then
lock_bots = "نعم"
elseif redis:get(Jack.."Jack:Lock:Bot:kick"..ChatId) == "ked" then
lock_bots = "بالتقيد "   
elseif redis:get(Jack.."Jack:Lock:Bot:kick"..ChatId) == "kick" then
lock_bots = "بالطرد "    
else
lock_bots = "لا "    
end
if redis:get(Jack.."Jack:Lock:Markdaun"..ChatId) == "del" then
lock_mark = "نعم"
elseif redis:get(Jack.."Jack:Lock:Markdaun"..ChatId) == "ked" then 
lock_mark = "بالتقيد "    
elseif redis:get(Jack.."Jack:Lock:Markdaun"..ChatId) == "ktm" then 
lock_mark = "بالكتم "    
elseif redis:get(Jack.."Jack:Lock:Markdaun"..ChatId) == "kick" then 
lock_mark = "بالطرد "    
else
lock_mark = "لا "    
end
if redis:get(Jack.."Jack:Lock:Spam"..ChatId) == "del" then    
lock_spam = "نعم"
elseif redis:get(Jack.."Jack:Lock:Spam"..ChatId) == "ked" then 
lock_spam = "بالتقيد "    
elseif redis:get(Jack.."Jack:Lock:Spam"..ChatId) == "ktm" then 
lock_spam = "بالكتم "    
elseif redis:get(Jack.."Jack:Lock:Spam"..ChatId) == "kick" then 
lock_spam = "بالطرد "    
else
lock_spam = "لا "    
end        
return{
lock_pin = lock_pin,
lock_tagservr = lock_tagservr,
lock_text = lock_text,
lock_add = lock_add,
lock_join = lock_join,
lock_edit = lock_edit,
flood = flood,
lock_photo = lock_photo,
lock_phon = lock_phon,
lock_links = lock_links,
lock_cmds = lock_cmds,
lock_mark = lock_mark,
lock_user = lock_user,
lock_hash = lock_hash,
lock_muse = lock_muse,
lock_ved = lock_ved,
lock_gif = lock_gif,
lock_ste = lock_ste,
lock_geam = lock_geam,
lock_vico = lock_vico,
lock_inlin = lock_inlin,
lock_fwd = lock_fwd,
lock_file = lock_file,
lock_self = lock_self,
lock_bots = lock_bots,
lock_spam = lock_spam
}
end
function Total_message(Message)  
local MsgText = ''  
if tonumber(Message) < 100 then 
MsgText = 'تفاعل محلو 😤' 
elseif tonumber(Message) < 200 then 
MsgText = 'تفاعلك ضعيف ليش'
elseif tonumber(Message) < 400 then 
MsgText = 'عفيه اتفاعل 😽' 
elseif tonumber(Message) < 700 then 
MsgText = 'شكد تحجي😒' 
elseif tonumber(Message) < 1200 then 
MsgText = 'ملك التفاعل 😼' 
elseif tonumber(Message) < 2000 then 
MsgText = 'موش تفاعل غنبله' 
elseif tonumber(Message) < 3500 then 
MsgText = 'اساس لتفاعل ياب'  
elseif tonumber(Message) < 4000 then 
MsgText = 'عوف لجواهر وتفاعل بزودك' 
elseif tonumber(Message) < 4500 then 
MsgText = 'قمة التفاعل' 
elseif tonumber(Message) < 5500 then 
MsgText = 'شهلتفاعل استمر يكيك' 
elseif tonumber(Message) < 7000 then 
MsgText = 'غنبله وربي 🌟' 
elseif tonumber(Message) < 9500 then 
MsgText = 'حلغوم مال تفاعل' 
elseif tonumber(Message) < 10000000000 then 
MsgText = 'تفاعل نار وشرار'  
end 
return MsgText 
end

function Getpermissions(ChatId)
local Get_Chat = LuaTele.getChat(ChatId)
if Get_Chat.permissions.can_add_web_page_previews then
web = true else web = false
end
if Get_Chat.permissions.can_change_info then
info = true else info = false
end
if Get_Chat.permissions.can_invite_users then
invite = true else invite = false
end
if Get_Chat.permissions.can_pin_messages then
pin = true else pin = false
end
if Get_Chat.permissions.can_send_media_messages then
media = true else media = false
end
if Get_Chat.permissions.can_send_messages then
messges = true else messges = false
end
if Get_Chat.permissions.can_send_other_messages then
other = true else other = false
end
if Get_Chat.permissions.can_send_polls then
polls = true else polls = false
end

return{
web = web,
info = info,
invite = invite,
pin = pin,
media = media,
messges = messges,
other = other,
polls = polls
}
end
function Get_permissions(ChatId,UserId,MsgId)
local Get_Chat = LuaTele.getChat(ChatId)
if Get_Chat.permissions.can_add_web_page_previews then
web = '〖  نعم 〗' else web = '〖  لا 〗'
end
if Get_Chat.permissions.can_change_info then
info = '〖  نعم 〗' else info = '〖  لا 〗'
end
if Get_Chat.permissions.can_invite_users then
invite = '〖  نعم 〗' else invite = '〖  لا 〗'
end
if Get_Chat.permissions.can_pin_messages then
pin = '〖  نعم 〗' else pin = '〖  لا 〗'
end
if Get_Chat.permissions.can_send_media_messages then
media = '〖  نعم 〗' else media = '〖  لا 〗'
end
if Get_Chat.permissions.can_send_messages then
messges = '〖  نعم 〗' else messges = '〖  لا 〗'
end
if Get_Chat.permissions.can_send_other_messages then
other = '〖  نعم 〗' else other = '〖  لا 〗'
end
if Get_Chat.permissions.can_send_polls then
polls = '〖  نعم 〗' else polls = '〖  لا 〗'
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- ارسال الويب : '..web, data = UserId..'/web'}, 
},
{
{text = '- تغيير معلومات المجموعه : '..info, data = UserId.. '/info'}, 
},
{
{text = '- اضافه مستخدمين : '..invite, data = UserId.. '/invite'}, 
},
{
{text = '- تثبيت الرسائل : '..pin, data = UserId.. '/pin'}, 
},
{
{text = '- ارسال الميديا : '..media, data = UserId.. '/media'}, 
},
{
{text = '- ارسال الرسائل : .'..messges, data = UserId.. '/messges'}, 
},
{
{text = '- اضافه البوتات : '..other, data = UserId.. '/other'}, 
},
{
{text = '- ارسال استفتاء : '..polls, data = UserId.. '/polls'}, 
},
{
{text = '- اخفاء الامر ', data =IdUser..'/'.. 'delAmr'}
},
}
}
LuaTele.editMessageText(ChatId,MsgId,"•  صلاحيات المجموعه - ", "md", false, false, reply_markup)
end
function Statusrestricted(ChatId,UserId)
return{
BanAll = redis:sismember(Jack.."Jack:BanAll:Groups",UserId) ,
ktmall = redis:sismember(Jack.."Jack:ktmAll:Groups",UserId) ,
BanGroup = redis:sismember(Jack.."Jack:BanGroup:Group"..ChatId,UserId) ,
SilentGroup = redis:sismember(Jack.."Jack:SilentGroup:Group"..ChatId,UserId)
}
end
function Reply_Status(UserId,TextMsg)
local UserInfo = LuaTele.getUser(UserId)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
if UserInfo.username then
UserInfousername = '['..UserInfo.first_name..'](t.me/'..UserInfo.username..')'
else
UserInfousername = '['..UserInfo.first_name..'](tg://user?id='..UserId..')'
end
return {
Lock     = '\n• بواسطه ↤︎ '..UserInfousername..'\n'..TextMsg..'\n• خاصيه المسح ',
unLock   = '\n• بواسطه ↤︎ '..UserInfousername..'\n'..TextMsg,
lockKtm  = '\n• بواسطه ↤︎ '..UserInfousername..'\n'..TextMsg..'\n• خاصيه الكتم ',
lockKid  = '\n• بواسطه ↤︎ '..UserInfousername..'\n'..TextMsg..'\n• خاصيه التقييد ',
lockKick = '\n• بواسطه ↤︎ '..UserInfousername..'\n'..TextMsg..'\n• خاصيه الطرد ',
Reply    = '\n• المستخدم ↤︎ '..UserInfousername..'\n'..TextMsg..''
}
end
function StatusCanOrNotCan(ChatId,UserId)
Status = nil
DevelopersQ = redis:sismember(Jack.."Jack:DevelopersQ:Groups",UserId) 
Developers = redis:sismember(Jack.."Jack:Developers:Groups",UserId) 
TheBasics = redis:sismember(Jack..":MONSHA_Groupp:"..ChatId,UserId) 
Originators = redis:sismember(Jack.."Jack:Originators:Group"..ChatId,UserId)
Managers = redis:sismember(Jack.."Jack:Managers:Group"..ChatId,UserId)
Addictive = redis:sismember(Jack.."Jack:Addictive:Group"..ChatId,UserId)
Distinguished = redis:sismember(Jack.."Jack:Distinguished:Group"..ChatId,UserId)
StatusMember = LuaTele.getChatMember(ChatId,UserId).status.luatele
if UserId == 332581832 then
Status = true
elseif UserId == Sudo_Id then  
Status = true
elseif UserId == Jack then
Status = true
elseif DevelopersQ then
Status = true
elseif Developers then
Status = true
elseif TheBasics then
Status = true
elseif Originators then
Status = true
elseif Managers then
Status = true
elseif Addictive then
Status = true
elseif StatusMember == "chatMemberStatusCreator" then
Status = true
elseif StatusMember == "chatMemberStatusAdministrator" then
Status = true
else
Status = false
end  
return Status
end 
function StatusSilent(ChatId,UserId)
Status = nil
DevelopersQ = redis:sismember(Jack.."Jack:DevelopersQ:Groups",UserId) 
Developers = redis:sismember(Jack.."Jack:Developers:Groups",UserId) 
TheBasics = redis:sismember(Jack..":MONSHA_Groupp:"..ChatId,UserId) 
Originators = redis:sismember(Jack.."Jack:Originators:Group"..ChatId,UserId)
Managers = redis:sismember(Jack.."Jack:Managers:Group"..ChatId,UserId)
Addictive = redis:sismember(Jack.."Jack:Addictive:Group"..ChatId,UserId)
Distinguished = redis:sismember(Jack.."Jack:Distinguished:Group"..ChatId,UserId)
StatusMember = LuaTele.getChatMember(ChatId,UserId).status.luatele
if UserId == 332581832 then
Status = true
elseif UserId == Sudo_Id then    
Status = true
elseif UserId == Jack then
Status = true
elseif DevelopersQ then
Status = true
elseif Developers then
Status = true
elseif TheBasics then
Status = true
elseif Originators then
Status = true
elseif Managers then
Status = true
elseif Addictive then
Status = true
elseif StatusMember == "chatMemberStatusCreator" then
Status = true
else
Status = false
end  
return Status
end 
function getInputFile(file, conversion_str, expected_size)
local str = tostring(file)
if (conversion_str and expectedsize) then
return {
luatele = 'inputFileGenerated',
original_path = tostring(file),
conversion = tostring(conversion_str),
expected_size = expected_size
}
else
if str:match('/') then
return {
luatele = 'inputFileLocal',
path = file
}
elseif str:match('^%d+$') then
return {
luatele = 'inputFileId',
id = file
}
else
return {
luatele = 'inputFileRemote',
id = file
}
end
end
end
function GetInfoBot(msg)
local GetMemberStatus = LuaTele.getChatMember(msg.chat_id,Jack).status
if GetMemberStatus.can_change_info then
change_info = true else change_info = false
end
if GetMemberStatus.can_delete_messages then
delete_messages = true else delete_messages = false
end
if GetMemberStatus.can_invite_users then
invite_users = true else invite_users = false
end
if GetMemberStatus.can_pin_messages then
pin_messages = true else pin_messages = false
end
if GetMemberStatus.can_restrict_members then
restrict_members = true else restrict_members = false
end
if GetMemberStatus.can_promote_members then
promote = true else promote = false
end
return{
SetAdmin = promote,
BanUser = restrict_members,
Invite = invite_users,
PinMsg = pin_messages,
DelMsg = delete_messages,
Info = change_info
}
end
function GetApi(web)
local info, res = https.request(web)
if res ~= 200 then return false end
local success, res = pcall(JSON.decode, info);
if success then
if not res.ok then return false end
res = res
else
res = false
end
return res
end
function send_msg(chat_id,text,msg_id)
local url = Token..'/sendMessage?chat_id='..chat_id..'&text='..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true"
if msg_id then
url = url.."&reply_to_message_id="..msg_id/2097152/0.5
end
return GetApi(url)
end
function download(url,name)
if not name then
name = url:match('([^/]+)$')
end
if string.find(url,'https') then
data,res = https.request(url)
elseif string.find(url,'http') then
data,res = http.request(url)
else
return 'The link format is incorrect.'
end
if res ~= 200 then
return 'check url , error code : '..res
else
file = io.open(name,'wb')
file:write(data)
file:close()
print('Downloaded :> '..name)
return './'..name
end
end
function ChannelJoin(msg)
JoinChannel = true

return JoinChannel
end
function File_Bot_Run(msg,data)  
local msg_chat_id = msg.chat_id
local msg_reply_id = msg.reply_to_message_id
local msg_user_send_id = msg.sender.user_id
local msg_id = msg.id
redis:incr(Jack..'msgs:'..msg.chat_id..':'..msg.sender.user_id) 
if msg.date and msg.date < tonumber(os.time() - 15) then
print("->> Old Message End <<-")
return false
end
if data.content.text then
text = data.content.text.text
end
if tonumber(msg.sender.user_id) == tonumber(Jack) then
print('This is reply for Bot')
return false
end
if Statusrestricted(msg.chat_id,msg.sender.user_id).BanAll == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id}),LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
elseif Statusrestricted(msg.chat_id,msg.sender.user_id).ktmall == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Statusrestricted(msg.chat_id,msg.sender.user_id).BanGroup == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id}),LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
elseif Statusrestricted(msg.chat_id,msg.sender.user_id).SilentGroup == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
if tonumber(msg.sender.user_id) == 100300300 then
msg.TheRankCmd = 'Aec🎖'
msg.The_Controller = 1
elseif The_ControllerAll(msg.sender.user_id) == Jack then
msg.TheRankCmd = 'البوت'
elseif The_ControllerAll(msg.sender.user_id) == true then  
msg.The_Controller = 1
msg.TheRankCmd = 'Dev🎖'
elseif redis:sismember(Jack.."Jack:DevelopersQ:Groups",msg.sender.user_id) == true then
msg.The_Controller = 2
msg.TheRankCmd = ' Dev² 🎖'
elseif redis:sismember(Jack.."Jack:Developers:Groups",msg.sender.user_id) == true then
msg.The_Controller = 3
msg.TheRankCmd = redis:get(Jack.."Jack:Developer:Bot:Reply"..msg.chat_id) or ' Myth 🎖'
elseif redis:sismember(Jack..":MONSHA_Group:"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 44
msg.TheRankCmd = redis:get(Jack.."Jack:PresidentQ:Group:Reply"..msg.chat_id) or 'المالك'
elseif redis:sismember(Jack..":MONSHA_Groupp:"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 4
msg.TheRankCmd = redis:get(Jack.."Jack:President:Group:Reply"..msg.chat_id) or 'المنشئ الاساسي'
elseif redis:sismember(Jack.."Jack:Originators:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 5
msg.TheRankCmd = redis:get(Jack.."Jack:Constructor:Group:Reply"..msg.chat_id) or 'المنشئ '
elseif redis:sismember(Jack.."Jack:Managers:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 6
msg.TheRankCmd = redis:get(Jack.."Jack:Manager:Group:Reply"..msg.chat_id) or 'المدير '
elseif redis:sismember(Jack.."Jack:Addictive:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 7
msg.TheRankCmd = redis:get(Jack.."Jack:Admin:Group:Reply"..msg.chat_id) or 'الادمن '
elseif redis:sismember(Jack.."Jack:Distinguished:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 8
msg.TheRankCmd = redis:get(Jack.."Jack:Vip:Group:Reply"..msg.chat_id) or 'المميز '
elseif tonumber(msg.sender.user_id) == tonumber(Jack) then
msg.The_Controller = 9
else
msg.The_Controller = 10
msg.TheRankCmd = redis:get(Jack.."Jack:Mempar:Group:Reply"..msg.chat_id) or 'العضو '
end  
if msg.The_Controller == 1 then  
msg.ControllerBot = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 then
msg.DevelopersQ = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 then
msg.Developers = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 9 then
msg.TheBasicsm = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 9 then
msg.TheBasics = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 9 then
msg.Originators = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 6 or msg.The_Controller == 9 then
msg.Managers = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 6 or msg.The_Controller == 7 or msg.The_Controller == 9 then
msg.Addictive = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 6 or msg.The_Controller == 7 or msg.The_Controller == 8 or msg.The_Controller == 9 then
msg.Distinguished = true
end
if redis:get(Jack.."Jack:Lock:text"..msg_chat_id) and not msg.Distinguished then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
return false
end 
if msg.content.luatele == "messageChatJoinByLink" then
if redis:get(Jack.."Jack:Status:Welcome"..msg_chat_id) then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Welcome = redis:get(Jack.."Jack:Welcome:Group"..msg_chat_id)
if Welcome then 
if UserInfo.username then
UserInfousername = '@'..UserInfo.username
else
UserInfousername = 'لا يوجد '
end
Welcome = Welcome:gsub('{name}',UserInfo.first_name) 
Welcome = Welcome:gsub('{user}',UserInfousername) 
Welcome = Welcome:gsub('{NameCh}',Get_Chat.title) 
return LuaTele.sendText(msg_chat_id,msg_id,Welcome,"md")  
else
return LuaTele.sendText(msg_chat_id,msg_id,'• اطلق دخول ['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')\n• نورت القروب '..Get_Chat.title..'',"md")  
end
end
end
if not msg.Distinguished and msg.content.luatele ~= "messageChatAddMembers" and redis:hget(Jack.."Jack:Spam:Group:User"..msg_chat_id,"Spam:User") then 
if tonumber(msg.sender.user_id) == tonumber(Jack) then
return false
end
local floods = redis:hget(Jack.."Jack:Spam:Group:User"..msg_chat_id,"Spam:User") or "nil"
local Num_Msg_Max = redis:hget(Jack.."Jack:Spam:Group:User"..msg_chat_id,"Num:Spam") or 5
local post_count = tonumber(redis:get(Jack.."Jack:Spam:Cont"..msg.sender.user_id..":"..msg_chat_id) or 0)
if post_count >= tonumber(redis:hget(Jack.."Jack:Spam:Group:User"..msg_chat_id,"Num:Spam") or 5) then 
local type = redis:hget(Jack.."Jack:Spam:Group:User"..msg_chat_id,"Spam:User") 
if type == "kick" then 
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0), LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• قام بالتكرار في المجموعه وتم طرده").Reply,"md",true)
end
if type == "del" then 
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
if type == "keed" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0}), LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• قام بالتكرار في المجموعه وتم تقييده").Reply,"md",true)  
end
if type == "mute" then
redis:sadd(Jack.."Jack:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• قام بالتكرار في المجموعه وتم كتمه").Reply,"md",true)  
end
end
redis:setex(Jack.."Jack:Spam:Cont"..msg.sender.user_id..":"..msg_chat_id, tonumber(5), post_count+1) 
local edit_id = data.text_ or "nil"  
Num_Msg_Max = 5
if redis:hget(Jack.."Jack:Spam:Group:User"..msg_chat_id,"Num:Spam") then
Num_Msg_Max = redis:hget(Jack.."Jack:Spam:Group:User"..msg_chat_id,"Num:Spam") 
end
end 
if text and not msg.Distinguished then
local _nl, ctrl_ = string.gsub(text, "%c", "")  
local _nl, real_ = string.gsub(text, "%d", "")   
sens = 400  
if redis:get(Jack.."Jack:Lock:Spam"..msg.chat_id) == "del" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif redis:get(Jack.."Jack:Lock:Spam"..msg.chat_id) == "ked" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif redis:get(Jack.."Jack:Lock:Spam"..msg.chat_id) == "kick" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif redis:get(Jack.."Jack:Lock:Spam"..msg.chat_id) == "ktm" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
redis:sadd(Jack.."Jack:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
end
if msg.forward_info and not msg.Distinguished then -- التوجيه
local Fwd_Group = redis:get(Jack.."Jack:Lock:forward"..msg_chat_id)
if Fwd_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Fwd_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Fwd_Group == "ktm" then
redis:sadd(Jack.."Jack:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Fwd_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is forward')
return false
end 

if msg.reply_markup and msg.reply_markup.luatele == "replyMarkupInlineKeyboard" then
if not msg.Distinguished then  -- الكيبورد
local Keyboard_Group = redis:get(Jack.."Jack:Lock:Keyboard"..msg_chat_id)
if Keyboard_Group == "del" then
var(LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id}))
elseif Keyboard_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Keyboard_Group == "ktm" then
redis:sadd(Jack.."Jack:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Keyboard_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
end
print('This is reply_markup')
end 

if msg.content.location and not msg.Distinguished then  -- الموقع
if location then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
print('This is location')
end 

if msg.content.entities and msg..content.entities[0] and msg.content.entities[0].type.luatele == "textEntityTypeUrl" and not msg.Distinguished then  -- الماركداون
local Markduan_Gtoup = redis:get(Jack.."Jack:Lock:Markdaun"..msg_chat_id)
if Markduan_Gtoup == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Markduan_Gtoup == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Markduan_Gtoup == "ktm" then
redis:sadd(Jack.."Jack:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Markduan_Gtoup == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is textEntityTypeUrl')
end 

if msg.content.game and not msg.Distinguished then  -- الالعاب
local Games_Group = redis:get(Jack.."Jack:Lock:geam"..msg_chat_id)
if Games_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Games_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Games_Group == "ktm" then
redis:sadd(Jack.."Jack:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Games_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is games')
end 
if msg.content.luatele == "messagePinMessage" then -- رساله التثبيت
local Pin_Msg = redis:get(Jack.."Jack:lockpin"..msg_chat_id)
if Pin_Msg and not msg.Managers then
if Pin_Msg:match("(%d+)") then 
local PinMsg = LuaTele.pinChatMessage(msg_chat_id,Pin_Msg,true)
if PinMsg.luatele~= "ok" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لا استطيع تثبيت الرسائل ليست لديه صلاحيه","md",true)
end
end
local UnPin = LuaTele.unpinChatMessage(msg_chat_id) 
if UnPin.luatele ~= "ok" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لا استطيع الغاء تثبيت الرسائل ليست لديه صلاحيه","md",true)
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n• التثبيت معطل من قبل المدراء ","md",true)
end
print('This is message Pin')
end 


if msg.content.luatele == "messageChatAddMembers" then -- اضافه اشخاص
print('This is Add Membeers ')
redis:incr(Jack.."Jack:Num:Add:Memp"..msg_chat_id..":"..msg.sender.user_id) 
local AddMembrs = redis:get(Jack.."Jack:Lock:AddMempar"..msg_chat_id) 
local Lock_Bots = redis:get(Jack.."Jack:Lock:Bot:kick"..msg_chat_id)
for k,v in pairs(msg.content.member_user_ids) do
local Info_User = LuaTele.getUser(v) 
if Info_User.type.luatele == "userTypeBot" then
if Lock_Bots == "del" and not msg.Distinguished then
LuaTele.setChatMemberStatus(msg.chat_id,v,'banned',0)
elseif Lock_Bots == "kick" and not msg.Distinguished then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
LuaTele.setChatMemberStatus(msg.chat_id,v,'banned',0)
end
elseif Info_User.type.luatele == "userTypeRegular" then
redis:incr(Jack.."Jack:Num:Add:Memp"..msg.chat_id..":"..msg.sender.user_id) 
if AddMembrs == "kick" and not msg.Distinguished then
LuaTele.setChatMemberStatus(msg.chat_id,v,'banned',0)
end
end
end
end 

if msg.content.luatele == "messageContact" and not msg.Distinguished then  -- الجهات
local Contact_Group = redis:get(Jack.."Jack:Lock:Contact"..msg_chat_id)
if Contact_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Contact_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Contact_Group == "ktm" then
redis:sadd(Jack.."Jack:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Contact_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Contact')
end 

if msg.content.luatele == "messageVideoNote" and not msg.Distinguished then  -- بصمه الفيديو
local Videonote_Group = redis:get(Jack.."Jack:Lock:Unsupported"..msg_chat_id)
if Videonote_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Videonote_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Videonote_Group == "ktm" then
redis:sadd(Jack.."Jack:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Videonote_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is video Note')
end 

if msg.content.luatele == "messageDocument" and not msg.Distinguished then  -- الملفات
local Document_Group = redis:get(Jack.."Jack:Lock:Document"..msg_chat_id)
if Document_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Document_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Document_Group == "ktm" then
redis:sadd(Jack.."Jack:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Document_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Document')
end 

if msg.content.luatele == "messageAudio" and not msg.Distinguished then  -- الملفات الصوتيه
local Audio_Group = redis:get(Jack.."Jack:Lock:Audio"..msg_chat_id)
if Audio_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Audio_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Audio_Group == "ktm" then
redis:sadd(Jack.."Jack:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Audio_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Audio')
end 

if msg.content.luatele == "messageVideo" and not msg.Distinguished then  -- الفيديو
local Video_Grouo = redis:get(Jack.."Jack:Lock:Video"..msg_chat_id)
if Video_Grouo == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Video_Grouo == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Video_Grouo == "ktm" then
redis:sadd(Jack.."Jack:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Video_Grouo == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Video')
end 

if msg.content.luatele == "messageVoiceNote" and not msg.Distinguished then  -- البصمات
local Voice_Group = redis:get(Jack.."Jack:Lock:vico"..msg_chat_id)
if Voice_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Voice_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Voice_Group == "ktm" then
redis:sadd(Jack.."Jack:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Voice_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Voice')
end 

if msg.content.luatele == "messageSticker" and not msg.Distinguished then  -- الملصقات
local Sticker_Group = redis:get(Jack.."Jack:Lock:Sticker"..msg_chat_id)
if Sticker_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Sticker_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Sticker_Group == "ktm" then
redis:sadd(Jack.."Jack:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Sticker_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Sticker')
end 

if msg.via_bot_user_id ~= 0 and not msg.Distinguished then  -- انلاين
local Inlen_Group = redis:get(Jack.."Jack:Lock:Inlen"..msg_chat_id)
if Inlen_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Inlen_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Inlen_Group == "ktm" then
redis:sadd(Jack.."Jack:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Inlen_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is viabot')
end

if msg.content.luatele == "messageAnimation" and not msg.Distinguished then  -- المتحركات
local Gif_group = redis:get(Jack.."Jack:Lock:Animation"..msg_chat_id)
if Gif_group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Gif_group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Gif_group == "ktm" then
redis:sadd(Jack.."Jack:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Gif_group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Animation')
end 

if msg.content.photo and redis:get(Jack.."lock_id"..msg_chat_id) then
local Text = '-' 
local msg_id = msg.id/2097152/0.5 
https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(Text)) 
return false
end

if msg.content.luatele == "messagePhoto" and not msg.Distinguished then  -- الصور
local Photo_Group = redis:get(Jack.."Jack:Lock:Photo"..msg_chat_id)
if Photo_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Photo_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Photo_Group == "ktm" then
redis:sadd(Jack.."Jack:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Photo_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Photo delete')
end
if msg.content.photo and redis:get(Jack.."Jack:Chat:Photo"..msg_chat_id..":"..msg.sender.user_id) then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
local ChatPhoto = LuaTele.setChatPhoto(msg_chat_id,idPhoto)
if (ChatPhoto.luatele == "error") then
redis:del(Jack.."Jack:Chat:Photo"..msg_chat_id..":"..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• لا استطيع تغيير صوره المجموعه لاني لست ادمن او ليست لديه الصلاحيه ","md",true)    
end
redis:del(Jack.."Jack:Chat:Photo"..msg_chat_id..":"..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تغيير صوره المجموعه المجموعه الى ","md",true)    
end
if (text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") 
or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") 
or text and text:match("[Tt].[Mm][Ee]/") 
or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") 
or text and text:match(".[Pp][Ee]") 
or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") 
or text and text:match("[Hh][Tt][Tt][Pp]://") 
or text and text:match("[Ww][Ww][Ww].") 
or text and text:match(".[Cc][Oo][Mm]")) or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") or text and text:match("[Hh][Tt][Tt][Pp]://") or text and text:match("[Ww][Ww][Ww].") or text and text:match(".[Cc][Oo][Mm]") or text and text:match(".[Tt][Kk]") or text and text:match(".[Mm][Ll]") or text and text:match(".[Oo][Rr][Gg]") then 
local link_Group = redis:get(Jack.."Jack:Lock:Link"..msg_chat_id)  
if not msg.Distinguished then
if link_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif link_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif link_Group == "ktm" then
redis:sadd(Jack.."Jack:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif link_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is link ')
return false
end
end
if text and text:match("@[%a%d_]+") and not msg.Distinguished then 
local UserName_Group = redis:get(Jack.."Jack:Lock:User:Name"..msg_chat_id)
if UserName_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif UserName_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif UserName_Group == "ktm" then
redis:sadd(Jack.."Jack:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif UserName_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is username ')
end
if text and text:match("#[%a%d_]+") and not msg.Distinguished then 
local Hashtak_Group = redis:get(Jack.."Jack:Lock:hashtak"..msg_chat_id)
if Hashtak_Group == "del" then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Hashtak_Group == "ked" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Hashtak_Group == "ktm" then
redis:sadd(Jack.."Jack:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Hashtak_Group == "kick" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is hashtak ')
end
if text and text:match("/[%a%d_]+") and not msg.Distinguished then 
local comd_Group = redis:get(Jack.."Jack:Lock:Cmd"..msg_chat_id)
if comd_Group == "del" then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif comd_Group == "ked" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif comd_Group == "ktm" then
redis:sadd(Jack.."Jack:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif comd_Group == "kick" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
end
if (redis:get(Jack..'Jack:FilterText'..msg_chat_id..':'..msg.sender.user_id) == 'true') then
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
Filters = 'صوره'
redis:sadd(Jack.."Jack:List:Filter"..msg_chat_id,'photo:'..msg.content.photo.sizes[1].photo.id)  
redis:set(Jack.."Jack:Filter:Text"..msg.sender.user_id..':'..msg_chat_id, msg.content.photo.sizes[1].photo.id)  
elseif msg.content.animation then
Filters = 'متحركه'
redis:sadd(Jack.."Jack:List:Filter"..msg_chat_id,'animation:'..msg.content.animation.animation.id)  
redis:set(Jack.."Jack:Filter:Text"..msg.sender.user_id..':'..msg_chat_id, msg.content.animation.animation.id)  
elseif msg.content.sticker then
Filters = 'ملصق'
redis:sadd(Jack.."Jack:List:Filter"..msg_chat_id,'sticker:'..msg.content.sticker.sticker.id)  
redis:set(Jack.."Jack:Filter:Text"..msg.sender.user_id..':'..msg_chat_id, msg.content.sticker.sticker.id)  
elseif text then
redis:set(Jack.."Jack:Filter:Text"..msg.sender.user_id..':'..msg_chat_id, text)  
redis:sadd(Jack.."Jack:List:Filter"..msg_chat_id,'text:'..text)  
Filters = 'نص'
end
redis:set(Jack..'Jack:FilterText'..msg_chat_id..':'..msg.sender.user_id,'true1')
return LuaTele.sendText(msg_chat_id,msg_id,"\n• ارسل تحذير ( "..Filters.." ) عند ارساله","md",true)  
end
end
if text and (redis:get(Jack..'Jack:FilterText'..msg_chat_id..':'..msg.sender.user_id) == 'true1') then
local Text_Filter = redis:get(Jack.."Jack:Filter:Text"..msg.sender.user_id..':'..msg_chat_id)  
if Text_Filter then   
redis:set(Jack.."Jack:Filter:Group:"..Text_Filter..msg_chat_id,text)  
end  
redis:del(Jack.."Jack:Filter:Text"..msg.sender.user_id..':'..msg_chat_id)  
redis:del(Jack..'Jack:FilterText'..msg_chat_id..':'..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n• تم اضافه رد التحذير","md",true)  
end
if text and (redis:get(Jack..'Jack:FilterText'..msg_chat_id..':'..msg.sender.user_id) == 'DelFilter') then   
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
Filters = 'الصوره'
redis:srem(Jack.."Jack:List:Filter"..msg_chat_id,'photo:'..msg.content.photo.sizes[1].photo.id)  
redis:del(Jack.."Jack:Filter:Group:"..msg.content.photo.sizes[1].photo.id..msg_chat_id)  
elseif msg.content.animation then
Filters = 'المتحركه'
redis:srem(Jack.."Jack:List:Filter"..msg_chat_id,'animation:'..msg.content.animation.animation.id)  
redis:del(Jack.."Jack:Filter:Group:"..msg.content.animation.animation.id..msg_chat_id)  
elseif msg.content.sticker then
Filters = 'الملصق'
redis:srem(Jack.."Jack:List:Filter"..msg_chat_id,'sticker:'..msg.content.sticker.sticker.id)  
redis:del(Jack.."Jack:Filter:Group:"..msg.content.sticker.sticker.id..msg_chat_id)  
elseif text then
redis:srem(Jack.."Jack:List:Filter"..msg_chat_id,'text:'..text)  
redis:del(Jack.."Jack:Filter:Group:"..text..msg_chat_id)  
Filters = 'النص'
end
redis:del(Jack..'Jack:FilterText'..msg_chat_id..':'..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم الغاء منع ("..Filters..")","md",true)  
end
end
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
DelFilters = msg.content.photo.sizes[1].photo.id
statusfilter = 'الصوره'
elseif msg.content.animation then
DelFilters = msg.content.animation.animation.id
statusfilter = 'المتحركه'
elseif msg.content.sticker then
DelFilters = msg.content.sticker.sticker.id
statusfilter = 'الملصق'
elseif text then
DelFilters = text
statusfilter = 'الرساله'
end
local ReplyFilters = redis:get(Jack.."Jack:Filter:Group:"..DelFilters..msg_chat_id)
if ReplyFilters and not msg.Distinguished then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
return LuaTele.sendText(msg_chat_id,msg_id,"• لقد تم منع هذه ( "..statusfilter.." ) هنا\n• "..ReplyFilters,"md",true)   
end
end
if text and redis:get(Jack.."Jack:All:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id) == "true" then
local NewCmmd = redis:get(Jack.."Jack:All:Get:Reides:Commands:Group"..text)
if NewCmmd then
redis:del(Jack.."Jack:All:Get:Reides:Commands:Group"..text)
redis:del(Jack.."Jack:All:Command:Reids:Group:New"..msg_chat_id)
redis:srem(Jack.."Jack:All:Command:List:Group",text)
LuaTele.sendText(msg_chat_id,msg_id,"• تم ازالة هذا ↤︎  "..text.." ","md",true)
else
LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد امر بهذا الاسم","md",true)
end
redis:del(Jack.."Jack:All:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id)
return false
end
if text and redis:get(Jack.."Jack:All:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id) == "true" then
redis:set(Jack.."Jack:All:Command:Reids:Group:New"..msg_chat_id,text)
redis:del(Jack.."Jack:All:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id)
redis:set(Jack.."Jack:All:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id,"true1") 
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل الامر الجديد ليتم وضعه مكان القديم","md",true)  
end
if text and redis:get(Jack.."Jack:All:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id) == "true1" then
local NewCmd = redis:get(Jack.."Jack:All:Command:Reids:Group:New"..msg_chat_id)
redis:set(Jack.."Jack:All:Get:Reides:Commands:Group"..text,NewCmd)
redis:sadd(Jack.."Jack:All:Command:List:Group",text)
redis:del(Jack.."Jack:All:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حفظ الامر باسم ↤︎  "..text..' ',"md",true)
end

if text and redis:get(Jack.."Jack:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id) == "true" then
local NewCmmd = redis:get(Jack.."Jack:Get:Reides:Commands:Group"..msg_chat_id..":"..text)
if NewCmmd then
redis:del(Jack.."Jack:Get:Reides:Commands:Group"..msg_chat_id..":"..text)
redis:del(Jack.."Jack:Command:Reids:Group:New"..msg_chat_id)
redis:srem(Jack.."Jack:Command:List:Group"..msg_chat_id,text)
LuaTele.sendText(msg_chat_id,msg_id,"• تم ازالة هذا ↤︎  "..text.." ","md",true)
else
LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد امر بهذا الاسم","md",true)
end
redis:del(Jack.."Jack:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id)
return false
end
if text and redis:get(Jack.."Jack:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id) == "true" then
redis:set(Jack.."Jack:Command:Reids:Group:New"..msg_chat_id,text)
redis:del(Jack.."Jack:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id)
redis:set(Jack.."Jack:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id,"true1") 
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل الامر الجديد ليتم وضعه مكان القديم","md",true)  
end
if text and redis:get(Jack.."Jack:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id) == "true1" then
local NewCmd = redis:get(Jack.."Jack:Command:Reids:Group:New"..msg_chat_id)
redis:set(Jack.."Jack:Get:Reides:Commands:Group"..msg_chat_id..":"..text,NewCmd)
redis:sadd(Jack.."Jack:Command:List:Group"..msg_chat_id,text)
redis:del(Jack.."Jack:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حفظ الامر باسم ↤︎  "..text..' ',"md",true)
end
if redis:get(Jack.."Jack:Set:Link"..msg_chat_id..""..msg.sender.user_id) then
if text == "الغاء" then
redis:del(Jack.."Jack:Set:Link"..msg_chat_id..""..msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم الغاء حفظ الرابط")         
end
if text and text:match("(https://telegram.me/%S+)") or text and text:match("(https://t.me/%S+)") then     
local LinkGroup = text:match("(https://telegram.me/%S+)") or text:match("(https://t.me/%S+)")   
redis:set(Jack.."Jack:Group:Link"..msg_chat_id,LinkGroup)
redis:del(Jack.."Jack:Set:Link"..msg_chat_id..""..msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حفظ الرابط بنجاح","md",true)         
end
end 
if redis:get(Jack.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id) then 
if text == "الغاء" then 
redis:del(Jack.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id)  
return LuaTele.sendText(msg_chat_id,msg_id,"• تم الغاء حفظ الترحيب","md",true)   
end 
redis:del(Jack.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id)  
redis:set(Jack.."Jack:Welcome:Group"..msg_chat_id,text) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حفظ ترحيب المجموعه","md",true)     
end
if redis:get(Jack.."Jack:Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" then 
redis:del(Jack.."Jack:Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم الغاء حفظ القوانين","md",true)   
end 
redis:set(Jack.."Jack:Group:Rules" .. msg_chat_id,text) 
redis:del(Jack.."Jack:Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حفظ قوانين المجموعه","md",true)  
end  
if redis:get(Jack.."Jack:Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" then 
redis:del(Jack.."Jack:Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم الغاء حفظ وصف المجموعه","md",true)   
end 
LuaTele.setChatDescription(msg_chat_id,text) 
redis:del(Jack.."Jack:Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حفظ وصف المجموعه","md",true)  
end  
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo then
local test = redis:get(Jack.."Jack:Text:Manager"..msg.sender.user_id..":"..msg_chat_id.."")
if redis:get(Jack.."Jack:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id) == "true1" then
redis:del(Jack.."Jack:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id)
if msg.content.sticker then   
redis:set(Jack.."Jack:Add:Rd:Manager:Stekrs"..test..msg_chat_id, msg.content.sticker.sticker.remote.id)  
end   
if msg.content.voice_note then  
redis:set(Jack.."Jack:Add:Rd:Manager:Vico"..test..msg_chat_id, msg.content.voice_note.voice.remote.id)  
end   
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
redis:set(Jack.."Jack:Add:Rd:Manager:Text"..test..msg_chat_id, text)  
end  
if msg.content.audio then
redis:set(Jack.."Jack:Add:Rd:Manager:Audio"..test..msg_chat_id, msg.content.audio.audio.remote.id)  
end
if msg.content.document then
redis:set(Jack.."Jack:Add:Rd:Manager:File"..test..msg_chat_id, msg.content.document.document.remote.id)  
end
if msg.content.animation then
redis:set(Jack.."Jack:Add:Rd:Manager:Gif"..test..msg_chat_id, msg.content.animation.animation.remote.id)  
end
if msg.content.video_note then
redis:set(Jack.."Jack:Add:Rd:Manager:video_note"..test..msg_chat_id, msg.content.video_note.video.remote.id)  
end
if msg.content.video then
redis:set(Jack.."Jack:Add:Rd:Manager:Video"..test..msg_chat_id, msg.content.video.video.remote.id)  
end
if msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
print(idPhoto)
redis:set(Jack.."Jack:Add:Rd:Manager:Photo"..test..msg_chat_id, idPhoto)  
end
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حفظ رد للمدير بنجاح \n• ارسل ( "..test.." ) لرئية الرد","md",true)  
end  
end
if text and text:match("^(.*)$") then
if redis:get(Jack.."Jack:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id) == "true" then
redis:set(Jack.."Jack:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id,"true1")
redis:set(Jack.."Jack:Text:Manager"..msg.sender.user_id..":"..msg_chat_id, text)
redis:del(Jack.."Jack:Add:Rd:Manager:Gif"..text..msg_chat_id)   
redis:del(Jack.."Jack:Add:Rd:Manager:Vico"..text..msg_chat_id)   
redis:del(Jack.."Jack:Add:Rd:Manager:Stekrs"..text..msg_chat_id)     
redis:del(Jack.."Jack:Add:Rd:Manager:Text"..text..msg_chat_id)   
redis:del(Jack.."Jack:Add:Rd:Manager:Photo"..text..msg_chat_id)
redis:del(Jack.."Jack:Add:Rd:Manager:Video"..text..msg_chat_id)
redis:del(Jack.."Jack:Add:Rd:Manager:File"..text..msg_chat_id)
redis:del(Jack.."Jack:Add:Rd:Manager:video_note"..text..msg_chat_id)
redis:del(Jack.."Jack:Add:Rd:Manager:Audio"..text..msg_chat_id)
redis:sadd(Jack.."Jack:List:Manager"..msg_chat_id.."", text)
LuaTele.sendText(msg_chat_id,msg_id,[[
↯︙ارسل لي الرد سواء كان 
❨ ملف • ملصق • متحركه • صوره
 • فيديو • بصمه الفيديو • بصمه • صوت • رساله ❩
↯︙يمكنك اضافة الى النص •
━━━━━━━━━━━━
 `#اليوزر` ↬ معرف المستخدم
 `#الرسائل` ↬ عدد الرسائل
 `#name` ↬ اسم المستخدم
 `#الايدي` ↬ ايدي المستخدم
 `#الرتبه` ↬ رتبة المستخدم
 `#التعديل` ↬ عدد السحكات

]],"md",true)  
return false
end
end
if text and text:match("^(.*)$") then
if redis:get(Jack.."Jack:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id.."") == "true2" then
redis:del(Jack.."Jack:Add:Rd:Manager:Gif"..text..msg_chat_id)   
redis:del(Jack.."Jack:Add:Rd:Manager:Vico"..text..msg_chat_id)   
redis:del(Jack.."Jack:Add:Rd:Manager:Stekrs"..text..msg_chat_id)     
redis:del(Jack.."Jack:Add:Rd:Manager:Text"..text..msg_chat_id)   
redis:del(Jack.."Jack:Add:Rd:Manager:Photo"..text..msg_chat_id)
redis:del(Jack.."Jack:Add:Rd:Manager:Video"..text..msg_chat_id)
redis:del(Jack.."Jack:Add:Rd:Manager:File"..text..msg_chat_id)
redis:del(Jack.."Jack:Add:Rd:Manager:Audio"..text..msg_chat_id)
redis:del(Jack.."Jack:Add:Rd:Manager:video_note"..text..msg_chat_id)
redis:del(Jack.."Jack:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id)
redis:srem(Jack.."Jack:List:Manager"..msg_chat_id.."", text)
LuaTele.sendText(msg_chat_id,msg_id,"• تم حذف الرد من ردود المدير ","md",true)  
return false
end
end
if text and redis:get(Jack..'addrd_all:'..msg.chat_id..msg.sender.user_id) and redis:get(Jack..'allreplay:'..msg.chat_id..msg.sender.user_id) then
local klma = redis:get(Jack..'allreplay:'..msg.chat_id..msg.sender.user_id)
if msg.content.caption then redis:hset(Jack..':caption_replay:'..msg.chat_id,klma,msg.content.caption) end
if text then
redis:del(Jack..'addrd_all:'..msg.chat_id..msg.sender.user_id)
if utf8.len(text) > 4000 then 
return LuaTele.sendText(msg.chat_id,msg.id,"• عذرا غير مسموح باضافه جواب الرد باكثر من 4000 حرف تم الغاء الامر\n")
end
redis:hset(Jack..'replay:all',klma,text)
return LuaTele.sendText(msg.chat_id,msg.id,'(['..klma..'])\n   تم اضافت الرد لكل المجموعات  ')
end  
end

if text and redis:get(Jack.."replay"..msg.chat_id) then
local Replay = false
Replay = redis:hget(Jack..'replay:all',text)
if Replay then
Replay = convert_Klmat(msg,data,Replay,true)
LuaTele.sendText(msg.chat_id,msg.id,Flter_Markdown(Replay))
return false
end
end

if text and redis:get(Jack.."Jack:Status:ReplySudo"..msg_chat_id) then
local anemi = redis:get(Jack.."Jack:Add:Rd:Sudo:Gif"..text)   
local veico = redis:get(Jack.."Jack:Add:Rd:Sudo:vico"..text)   
local stekr = redis:get(Jack.."Jack:Add:Rd:Sudo:stekr"..text)     
local Text = redis:get(Jack.."Jack:Add:Rd:Sudo:Text"..text)   
local photo = redis:get(Jack.."Jack:Add:Rd:Sudo:Photo"..text)
local video = redis:get(Jack.."Jack:Add:Rd:Sudo:Video"..text)
local document = redis:get(Jack.."Jack:Add:Rd:Sudo:File"..text)
local audio = redis:get(Jack.."Jack:Add:Rd:Sudo:Audio"..text)
local video_note = redis:get(Jack.."Jack:Add:Rd:Sudo:video_note"..text)
if Text then 
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local NumMsg = redis:get(Jack..'msgs:'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalMsg = Total_message(NumMsg)
local Status_Gps = msg.TheRankCmd
local NumMessageEdit = redis:get(Jack..'Jack:Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local Text = Text:gsub('#اليوزر',(UserInfo.username or 'لا يوجد')) 
local Text = Text:gsub('#name',UserInfo.first_name)
local Text = Text:gsub('#الايدي',msg.sender.user_id)
local Text = Text:gsub('#التعديل',NumMessageEdit)
local Text = Text:gsub('#الرسائل',NumMsg)
local Text = Text:gsub('#الرتبه',Status_Gps)
LuaTele.sendText(msg_chat_id,msg_id,Text,"md",true)  
end
if video_note then
LuaTele.sendVideoNote(msg_chat_id, msg.id, video_note)
end
if photo then
LuaTele.sendPhotoo(msg.chat_id, msg.id, photo,'')
end  
if stekr then 
LuaTele.sendSticker(msg_chat_id, msg.id, stekr)
end
if veico then 
LuaTele.sendVoiceNote(msg_chat_id, msg.id, veico, '', "md")
end
if video then 
LuaTele.sendVideo(msg_chat_id, msg.id, video, '', "md")
end
if anemi then 
LuaTele.sendAnimation(msg_chat_id,msg.id, anemi, '', "md")
end
if document then
LuaTele.sendDocument(msg_chat_id, msg.id, document, '', "md")
end  
if audio then
LuaTele.sendAudio(msg_chat_id, msg.id, audio, '', "md") 
end
end
if text and redis:get(Jack.."Jack:Status:Reply"..msg_chat_id) then
local anemi = redis:get(Jack.."Jack:Add:Rd:Manager:Gif"..text..msg_chat_id)   
local veico = redis:get(Jack.."Jack:Add:Rd:Manager:Vico"..text..msg_chat_id)   
local stekr = redis:get(Jack.."Jack:Add:Rd:Manager:Stekrs"..text..msg_chat_id)     
local Texingt = redis:get(Jack.."Jack:Add:Rd:Manager:Text"..text..msg_chat_id)   
local photo = redis:get(Jack.."Jack:Add:Rd:Manager:Photo"..text..msg_chat_id)
local video = redis:get(Jack.."Jack:Add:Rd:Manager:Video"..text..msg_chat_id)
local document = redis:get(Jack.."Jack:Add:Rd:Manager:File"..text..msg_chat_id)
local audio = redis:get(Jack.."Jack:Add:Rd:Manager:Audio"..text..msg_chat_id)
local video_note = redis:get(Jack.."Jack:Add:Rd:Manager:video_note"..text..msg_chat_id)
if Texingt then 
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local NumMsg = redis:get(Jack..'msgs:'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalMsg = Total_message(NumMsg) 
local Status_Gps = msg.TheRankCmd
local NumMessageEdit = redis:get(Jack..'Jack:Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local Texingt = Texingt:gsub('#اليوزر',(UserInfo.username or 'لا يوجد')) 
local Texingt = Texingt:gsub('#name',UserInfo.first_name)
local Texingt = Texingt:gsub('#الايدي',msg.sender.user_id)
local Texingt = Texingt:gsub('#التعديل',NumMessageEdit)
local Texingt = Texingt:gsub('#الرسائل',NumMsg)
local Texingt = Texingt:gsub('#الرتبه',Status_Gps)
LuaTele.sendText(msg_chat_id,msg_id,Texingt,"md",true)  
end
if video_note then
LuaTele.sendVideoNote(msg_chat_id, msg.id, video_note)
end
if photo then
LuaTele.sendPhoto(msg.chat_id, msg.id, photo,'')
end  
if stekr then 
LuaTele.sendSticker(msg_chat_id, msg.id, stekr)
end
if veico then 
LuaTele.sendVoiceNote(msg_chat_id, msg.id, veico, '', "md")
end
if video then 
LuaTele.sendVideo(msg_chat_id, msg.id, video, '', "md")
end
if anemi then 
LuaTele.sendAnimation(msg_chat_id,msg.id, anemi, '', "md")
end
if document then
LuaTele.sendDocument(msg_chat_id, msg.id, document, '', "md")
end  
if audio then
LuaTele.sendAudio(msg_chat_id, msg.id, audio, '', "md") 
end
end
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo then
local test = redis:get(Jack.."Jack:Text:Sudo:Bot"..msg.sender.user_id..":"..msg_chat_id)
if redis:get(Jack.."Jack:Set:Rd"..msg.sender.user_id..":"..msg_chat_id) == "true1" then
redis:del(Jack.."Jack:Set:Rd"..msg.sender.user_id..":"..msg_chat_id)
if msg.content.sticker then   
redis:set(Jack.."Jack:Add:Rd:Sudo:stekr"..test, msg.content.sticker.sticker.remote.id)  
end   
if msg.content.voice_note then  
redis:set(Jack.."Jack:Add:Rd:Sudo:vico"..test, msg.content.voice_note.voice.remote.id)  
end   
if msg.content.animation then   
redis:set(Jack.."Jack:Add:Rd:Sudo:Gif"..test, msg.content.animation.animation.remote.id)  
end  
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
redis:set(Jack.."Jack:Add:Rd:Sudo:Text"..test, text)  
end  
if msg.content.audio then
redis:set(Jack.."Jack:Add:Rd:Sudo:Audio"..test, msg.content.audio.audio.remote.id)  
end
if msg.content.document then
redis:set(Jack.."Jack:Add:Rd:Sudo:File"..test, msg.content.document.document.remote.id)  
end
if msg.content.video then
redis:set(Jack.."Jack:Add:Rd:Sudo:Video"..test, msg.content.video.video.remote.id)  
end
if msg.content.video_note then
redis:set(Jack.."Jack:Add:Rd:Sudo:video_note"..test..msg_chat_id, msg.content.video_note.video.remote.id)  
end


if msg.content.photo then
if msg.content.photo.sizes[3] then 
idPhoto = msg.content.photo.sizes[3].photo.remote.id
else 
idPhoto = msg.content.photo.sizes[0].photo.remote.id
end
redis:set(Jack.."Jack:Add:Rd:Sudo:Photo"..test, idPhoto)  
end
LuaTele.sendText(msg_chat_id,msg_id,"• تم حفظ رد للمطور \n• ارسل ( "..test.." ) لرئية الرد","md",true)  
return false
end  
end
if text and text:match("^(.*)$") then
if redis:get(Jack.."Jack:Set:Rd"..msg.sender.user_id..":"..msg_chat_id) == "true" then
redis:set(Jack.."Jack:Set:Rd"..msg.sender.user_id..":"..msg_chat_id, "true1")
redis:set(Jack.."Jack:Text:Sudo:Bot"..msg.sender.user_id..":"..msg_chat_id, text)
redis:sadd(Jack.."Jack:List:Rd:Sudo", text)
LuaTele.sendText(msg_chat_id,msg_id,[[
↯︙ارسل لي الرد سواء كان 
❨ ملف • ملصق • متحركه • صوره
 • فيديو • بصمه الفيديو • بصمه • صوت • رساله ❩
↯︙يمكنك اضافة الى النص •
━━━━━━━━━━━━
 `#اليوزر` ↬ معرف المستخدم
 `#الرسائل` ↬ عدد الرسائل
 `#name` ↬ اسم المستخدم
 `#الايدي` ↬ ايدي المستخدم
 `#الرتبه` ↬ رتبة المستخدم
 `#التعديل` ↬ عدد السحكات

]],"md",true)  
return false
end
end
if text and text:match("^(.*)$") then
if redis:get(Jack.."Jack:Set:On"..msg.sender.user_id..":"..msg_chat_id) == "true" then
list = {"Add:Rd:Sudo:video_note","Add:Rd:Sudo:Audio","Add:Rd:Sudo:File","Add:Rd:Sudo:Video","Add:Rd:Sudo:Photo","Add:Rd:Sudo:Text","Add:Rd:Sudo:stekr","Add:Rd:Sudo:vico","Add:Rd:Sudo:Gif"}
for k,v in pairs(list) do
redis:del(Jack..'Jack:'..v..text)
end
redis:del(Jack.."Jack:Set:On"..msg.sender.user_id..":"..msg_chat_id)
redis:srem(Jack.."Jack:List:Rd:Sudo", text)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حذف الرد من ردود المطور","md",true)  
end
end
if redis:get(Jack.."Jack:Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر' then   
redis:del(Jack.."Jack:Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n• تم الغاء الاذاعه للمجموعات","md",true)  
end 
local list = redis:smembers(Jack.."group:ids") 
if msg.content.video_note then
for k,v in pairs(list) do 
LuaTele.sendVideoNote(v, 0, msg.content.video_note.video.remote.id)
redis:set(Jack.."Jack:PinMsegees:"..v,msg.content.video_note.video.remote.id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
for k,v in pairs(list) do 
LuaTele.sendPhoto(v, 0, idPhoto,'')
redis:set(Jack.."Jack:PinMsegees:"..v,idPhoto)
end
elseif msg.content.sticker then 
for k,v in pairs(list) do 
LuaTele.sendSticker(v, 0, msg.content.sticker.sticker.remote.id)
redis:set(Jack.."Jack:PinMsegees:"..v,msg.content.sticker.sticker.remote.id)
end
elseif msg.content.voice_note then 
for k,v in pairs(list) do 
LuaTele.sendVoiceNote(v, 0, msg.content.voice_note.voice.remote.id, '', "md")
redis:set(Jack.."Jack:PinMsegees:"..v,msg.content.voice_note.voice.remote.id)
end
elseif msg.content.video then 
for k,v in pairs(list) do 
LuaTele.sendVideo(v, 0, msg.content.video.video.remote.id, '', "md")
redis:set(Jack.."Jack:PinMsegees:"..v,msg.content.video.video.remote.id)
end
elseif msg.content.animation then 
for k,v in pairs(list) do 
LuaTele.sendAnimation(v,0, msg.content.animation.animation.remote.id, '', "md")
redis:set(Jack.."Jack:PinMsegees:"..v,msg.content.animation.animation.remote.id)
end
elseif msg.content.document then
for k,v in pairs(list) do 
LuaTele.sendDocument(v, 0, msg.content.document.document.remote.id, '', "md")
redis:set(Jack.."Jack:PinMsegees:"..v,msg.content.document.document.remote.id)
end
elseif msg.content.audio then
for k,v in pairs(list) do 
LuaTele.sendAudio(v, 0, msg.content.audio.audio.remote.id, '', "md") 
redis:set(Jack.."Jack:PinMsegees:"..v,msg.content.audio.audio.remote.id)
end
elseif text then
for k,v in pairs(list) do 
LuaTele.sendText(v,0,text,"md",true)
redis:set(Jack.."Jack:PinMsegees:"..v,text)
end
end
LuaTele.sendText(msg_chat_id,msg_id,"• تمت الاذاعه الى - "..#list.."  مجموعه في البوت ","md",true)      
redis:del(Jack.."Jack:Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return false
end
------------------------------------------------------------------------------------------------------------
if redis:get(Jack.."Jack:Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر' then   
redis:del(Jack.."Jack:Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n• تم الغاء الاذاعه خاص","md",true)  
end 
local list = redis:smembers(Jack..'users')  
if msg.content.video_note then
for k,v in pairs(list) do 
LuaTele.sendVideoNote(v, 0, msg.content.video_note.video.remote.id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
for k,v in pairs(list) do 
LuaTele.sendPhoto(v, 0, idPhoto,'')
end
elseif msg.content.sticker then 
for k,v in pairs(list) do 
LuaTele.sendSticker(v, 0, msg.content.sticker.sticker.remote.id)
end
elseif msg.content.voice_note then 
for k,v in pairs(list) do 
LuaTele.sendVoiceNote(v, 0, msg.content.voice_note.voice.remote.id, '', "md")
end
elseif msg.content.video then 
for k,v in pairs(list) do 
LuaTele.sendVideo(v, 0, msg.content.video.video.remote.id, '', "md")
end
elseif msg.content.animation then 
for k,v in pairs(list) do 
LuaTele.sendAnimation(v,0, msg.content.animation.animation.remote.id, '', "md")
end
elseif msg.content.document then
for k,v in pairs(list) do 
LuaTele.sendDocument(v, 0, msg.content.document.document.remote.id, '', "md")
end
elseif msg.content.audio then
for k,v in pairs(list) do 
LuaTele.sendAudio(v, 0, msg.content.audio.audio.remote.id, '', "md") 
end
elseif text then
for k,v in pairs(list) do 
LuaTele.sendText(v,0,text,"md",true)
end
end
LuaTele.sendText(msg_chat_id,msg_id,"• تمت الاذاعه الى - "..#list.."  مشترك في البوت ","md",true)      
redis:del(Jack.."Jack:Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return false
end
------------------------------------------------------------------------------------------------------------
if redis:get(Jack.."Jack:Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر' then   
redis:del(Jack.."Jack:Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n• تم الغاء الاذاعه للمجموعات","md",true)  
end 
local list = redis:smembers(Jack.."group:ids") 
if msg.content.video_note then
for k,v in pairs(list) do 
LuaTele.sendVideoNote(v, 0, msg.content.video_note.video.remote.id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
for k,v in pairs(list) do 
LuaTele.sendPhoto(v, 0, idPhoto,'')
end
elseif msg.content.sticker then 
for k,v in pairs(list) do 
LuaTele.sendSticker(v, 0, msg.content.sticker.sticker.remote.id)
end
elseif msg.content.voice_note then 
for k,v in pairs(list) do 
LuaTele.sendVoiceNote(v, 0, msg.content.voice_note.voice.remote.id, '', "md")
end
elseif msg.content.video then 
for k,v in pairs(list) do 
LuaTele.sendVideo(v, 0, msg.content.video.video.remote.id, '', "md")
end
elseif msg.content.animation then 
for k,v in pairs(list) do 
LuaTele.sendAnimation(v,0, msg.content.animation.animation.remote.id, '', "md")
end
elseif msg.content.document then
for k,v in pairs(list) do 
LuaTele.sendDocument(v, 0, msg.content.document.document.remote.id, '', "md")
end
elseif msg.content.audio then
for k,v in pairs(list) do 
LuaTele.sendAudio(v, 0, msg.content.audio.audio.remote.id, '', "md") 
end
elseif text then
for k,v in pairs(list) do 
LuaTele.sendText(v,0,text,"md",true)
end
end
LuaTele.sendText(msg_chat_id,msg_id,"• تمت الاذاعه الى - "..#list.."  مجموعه في البوت ","md",true)      
redis:del(Jack.."Jack:Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return false
end
------------------------------------------------------------------------------------------------------------
if redis:get(Jack.."Jack:Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر' then   
redis:del(Jack.."Jack:Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n• تم الغاء الاذاعه بالتوجيه للمجموعات","md",true)    
end 
if msg.forward_info then 
local list = redis:smembers(Jack.."group:ids")   
LuaTele.sendText(msg_chat_id,msg_id,"• تم التوجيه الى - "..#list.."  مجموعه في البوت ","md",true)      
for k,v in pairs(list) do  
LuaTele.forwardMessages(v, msg_chat_id, msg_id,0,0,true,false,false)
end   
redis:del(Jack.."Jack:Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
end 
return false
end
------------------------------------------------------------------------------------------------------------
if redis:get(Jack.."Jack:Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر' then   
redis:del(Jack.."Jack:Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n• تم الغاء الاذاعه بالتوجيه خاص","md",true)    
end 
if msg.forward_info then 
local list = redis:smembers(Jack.."users")   
LuaTele.sendText(msg_chat_id,msg_id,"• تم التوجيه الى - "..#list.."  مجموعه في البوت ","md",true) 
for k,v in pairs(list) do  
LuaTele.forwardMessages(v, msg_chat_id, msg_id,0,1,msg.media_album_id,false,true)
end   
redis:del(Jack.."Jack:Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
end 
return false
end
if text and redis:get(Jack..'jsors'..msg_chat_id..':'..msg.sender.user_id) then
if text == 'الغاء' or text == 'الغاء الامر' then 
redis:del(Jack..'Jack:GetTexting:DevJack'..msg_chat_id..':'..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,'• تم الغاء حفظ كليشة السورس')
end
redis:set(Jack..'sors',text)
redis:del(Jack..'jsors'..msg_chat_id..':'..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,'• تم حفظ كليشة السورس')
end
if text and redis:get(Jack..'Jack:GetTexting:DevJack'..msg_chat_id..':'..msg.sender.user_id) then
if text == 'الغاء' or text == 'الغاء الامر' then 
redis:del(Jack..'Jack:GetTexting:DevJack'..msg_chat_id..':'..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,'• تم الغاء حفظ كليشة المطور')
end
redis:set(Jack..'Jack:Texting:DevJack',text)
redis:del(Jack..'Jack:GetTexting:DevJack'..msg_chat_id..':'..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,'• تم حفظ كليشة المطور')
end
if redis:get(Jack.."Jack:redis:Id:Groups"..msg.chat_id..""..msg.sender.user_id) then 
if text == 'الغاء' then 
LuaTele.sendText(msg_chat_id,msg_id, "\n• تم الغاء امر تعين الايدي عام","md",true)  
redis:del(Jack.."Jack:redis:Id:Groups"..msg.chat_id..""..msg.sender.user_id) 
return false  
end 
redis:del(Jack.."Jack:redis:Id:Groups"..msg.chat_id..""..msg.sender.user_id) 
redis:set(Jack.."Jack:Set:Id:Groups",text:match("(.*)"))
LuaTele.sendText(msg_chat_id,msg_id,'• تم تعين الايدي عام',"md",true)  
end
if redis:get(Jack.."Jack:redis:Id:Group"..msg.chat_id..""..msg.sender.user_id) then 
if text == 'الغاء' then 
LuaTele.sendText(msg_chat_id,msg_id, "\n• تم الغاء امر تعين الايدي","md",true)  
redis:del(Jack.."Jack:redis:Id:Group"..msg.chat_id..""..msg.sender.user_id) 
return false  
end 
redis:del(Jack.."Jack:redis:Id:Group"..msg.chat_id..""..msg.sender.user_id) 
redis:set(Jack.."Jack:Set:Id:Group"..msg.chat_id,text:match("(.*)"))
LuaTele.sendText(msg_chat_id,msg_id,'• تم تعين الايدي الجديد',"md",true)  
end
if redis:get(Jack.."Jack:Change:Name:Bot"..msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر' then   
redis:del(Jack.."Jack:Change:Name:Bot"..msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n• تم الغاء امر تغير اسم البوت","md",true)  
end 
redis:del(Jack.."Jack:Change:Name:Bot"..msg.sender.user_id) 
redis:set(Jack.."Jack:Name:Bot",text) 
return LuaTele.sendText(msg_chat_id,msg_id, "•  تم تغير اسم البوت الى - "..text,"md",true)    
end 
if redis:get(Jack.."Jack:Change:Start:Bot"..msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر' then   
redis:del(Jack.."Jack:Change:Start:Bot"..msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n• تم الغاء امر تغير كليشه start","md",true)  
end 
redis:del(Jack.."Jack:Change:Start:Bot"..msg.sender.user_id) 
redis:set(Jack.."Jack:Start:Bot",text) 
return LuaTele.sendText(msg_chat_id,msg_id, "•  تم تغيير كليشه start - "..text,"md",true)    
end 
if redis:get(Jack.."Jack:Game:Smile"..msg.chat_id) then
if text == redis:get(Jack.."Jack:Game:Smile"..msg.chat_id) then
redis:incrby(Jack.."Jack:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
redis:del(Jack.."Jack:Game:Smile"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لقد فزت في اللعبه \n• اللعب مره اخرى وارسل - سمايل او سمايلات","md",true)  
else
redis:del(Jack.."Jack:Game:Smile"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لقد خسرت حضا اوفر في المره القادمه\n• اللعب مره اخرى وارسل - سمايل او سمايلات","md",true)  
end
end 
if redis:get(Jack.."Jack:Game:Monotonous"..msg.chat_id) then
if text == redis:get(Jack.."Jack:Game:Monotonous"..msg.chat_id) then
redis:del(Jack.."Jack:Game:Monotonous"..msg.chat_id)
redis:incrby(Jack.."Jack:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لقد فزت في اللعبه \n• اللعب مره اخرى وارسل - الاسرع او ترتيب","md",true)  
else
redis:del(Jack.."Jack:Game:Monotonous"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لقد خسرت حضا اوفر في المره القادمه\n• اللعب مره اخرى وارسل - الاسرع او ترتيب","md",true)  
end
end 
if redis:get(Jack.."Jack:Game:Riddles"..msg.chat_id) then
if text == redis:get(Jack.."Jack:Game:Riddles"..msg.chat_id) then
redis:incrby(Jack.."Jack:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
redis:del(Jack.."Jack:Game:Riddles"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لقد فزت في اللعبه \n• اللعب مره اخرى وارسل - حزوره","md",true)  
else
redis:del(Jack.."Jack:Game:Riddles"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لقد خسرت حضا اوفر في المره القادمه\n• اللعب مره اخرى وارسل - حزوره","md",true)  
end
end
if redis:get(Jack.."Jack:Game:Meaningof"..msg.chat_id) then
if text == redis:get(Jack.."Jack:Game:Meaningof"..msg.chat_id) then
redis:incrby(Jack.."Jack:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
redis:del(Jack.."Jack:Game:Meaningof"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لقد فزت في اللعبه \n• اللعب مره اخرى وارسل - معاني","md",true)  
else
redis:del(Jack.."Jack:Game:Meaningof"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لقد خسرت حضا اوفر في المره القادمه\n• اللعب مره اخرى وارسل - معاني","md",true)  
end
end
if redis:get(Jack.."Jack:Game:Reflection"..msg.chat_id) then
if text == redis:get(Jack.."Jack:Game:Reflection"..msg.chat_id) then
redis:incrby(Jack.."Jack:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
redis:del(Jack.."Jack:Game:Reflection"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لقد فزت في اللعبه \n• اللعب مره اخرى وارسل - العكس","md",true)  
else
redis:del(Jack.."Jack:Game:Reflection"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لقد خسرت حضا اوفر في المره القادمه\n• اللعب مره اخرى وارسل - العكس","md",true)  
end
end
if redis:get(Jack.."Jack:Game:Estimate"..msg.chat_id..msg.sender.user_id) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 20 then
return LuaTele.sendText(msg_chat_id,msg_id,"• عذراً لا يمكنك تخمين عدد اكبر من ال  20  خمن رقم ما بين ال 1 و 20 \n","md",true)  
end 
local GETNUM = redis:get(Jack.."Jack:Game:Estimate"..msg.chat_id..msg.sender.user_id)
if tonumber(NUM) == tonumber(GETNUM) then
redis:del(Jack.."Jack:SADD:NUM"..msg.chat_id..msg.sender.user_id)
redis:del(Jack.."Jack:Game:Estimate"..msg.chat_id..msg.sender.user_id)
redis:incrby(Jack.."Jack:Num:Add:Games"..msg.chat_id..msg.sender.user_id,5)  
return LuaTele.sendText(msg_chat_id,msg_id,"• مبروك فزت ويانه وخمنت الرقم الصحيح\n🚸︙تم اضافة  5  من النقاط \n","md",true)  
elseif tonumber(NUM) ~= tonumber(GETNUM) then
redis:incrby(Jack.."Jack:SADD:NUM"..msg.chat_id..msg.sender.user_id,1)
if tonumber(redis:get(Jack.."Jack:SADD:NUM"..msg.chat_id..msg.sender.user_id)) >= 3 then
redis:del(Jack.."Jack:SADD:NUM"..msg.chat_id..msg.sender.user_id)
redis:del(Jack.."Jack:Game:Estimate"..msg.chat_id..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• اوبس لقد خسرت في اللعبه \n• حظآ اوفر في المره القادمه \n• كان الرقم الذي تم تخمينه  "..GETNUM.." ","md",true)  
else
return LuaTele.sendText(msg_chat_id,msg_id,"• اوبس تخمينك غلط \n• ارسل رقم تخمنه مره اخرى ","md",true)  
end
end
end
end
if redis:get(Jack.."Jack:Game:Difference"..msg.chat_id) then
if text == redis:get(Jack.."Jack:Game:Difference"..msg.chat_id) then 
redis:del(Jack.."Jack:Game:Difference"..msg.chat_id)
redis:incrby(Jack.."Jack:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لقد فزت في اللعبه \n• اللعب مره اخرى وارسل - المختلف","md",true)  
else
redis:del(Jack.."Jack:Game:Difference"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لقد خسرت حضا اوفر في المره القادمه\n• اللعب مره اخرى وارسل - المختلف","md",true)  
end
end
if redis:get(Jack.."Jack:Game:Example"..msg.chat_id) then
if text == redis:get(Jack.."Jack:Game:Example"..msg.chat_id) then 
redis:del(Jack.."Jack:Game:Example"..msg.chat_id)
redis:incrby(Jack.."Jack:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لقد فزت في اللعبه \n• اللعب مره اخرى وارسل - امثله","md",true)  
else
redis:del(Jack.."Jack:Game:Example"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لقد خسرت حضا اوفر في المره القادمه\n• اللعب مره اخرى وارسل - امثله","md",true)  
end
end
if text then
local NewCmmd = redis:get(Jack.."Jack:All:Get:Reides:Commands:Group"..text) or redis:get(Jack.."Jack:Get:Reides:Commands:Group"..msg_chat_id..":"..text)
if NewCmmd then
text = (NewCmmd or text)
end
end
if text == 'رفع النسخه الاحتياطيه' and msg.reply_to_message_id ~= 0 or text == 'رفع نسخه احتياطيه' and msg.reply_to_message_id ~= 0 then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.document then
local File_Id = Message_Reply.content.document.document.remote.id
local Name_File = Message_Reply.content.document.file_name
if Name_File ~= UserBot..'.json' then
return LuaTele.sendText(msg_chat_id,msg_id,'• عذرا هذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه')
end -- end Namefile
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..File_Id)) 
local download_ = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,''..Name_File) 
local Get_Info = io.open(download_,"r"):read('*a')
local FilesJson = JSON.decode(Get_Info)
if tonumber(Jack) ~= tonumber(FilesJson.BotId) then
return LuaTele.sendText(msg_chat_id,msg_id,'• عذرا هذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه')
end -- end botid
LuaTele.sendText(msg_chat_id,msg_id,'• جاري استرجاع المشتركين والقروبات ...')
Y = 0
for k,v in pairs(FilesJson.UsersBot) do
Y = Y + 1
redis:sadd(Jack..'users',v)  
end
X = 0
for GroupId,ListGroup in pairs(FilesJson.GroupsBot) do
X = X + 1
redis:sadd(Jack.."group:ids",GroupId) 
if ListGroup.President then
for k,v in pairs(ListGroup.President) do
redis:sadd(Jack..":MONSHA_Groupp:"..GroupId,v)
end
end
if ListGroup.Constructor then
for k,v in pairs(ListGroup.Constructor) do
redis:sadd(Jack.."Jack:Originators:Group"..GroupId,v)
end
end
if ListGroup.Manager then
for k,v in pairs(ListGroup.Manager) do
redis:sadd(Jack.."Jack:Managers:Group"..GroupId,v)
end
end
if ListGroup.Admin then
for k,v in pairs(ListGroup.Admin) do
redis:sadd(Jack.."Jack:Addictive:Group"..GroupId,v)
end
end
if ListGroup.Vips then
for k,v in pairs(ListGroup.Vips) do
redis:sadd(Jack.."Jack:Distinguished:Group"..GroupId,v)
end
end 
end
return LuaTele.sendText(msg_chat_id,msg_id,'• تم استرجاع '..X..' مجموعه \n• واسترجاع '..Y..' مشترك في البوت')
end
end
if text == 'رفع نسخه جاك' and msg.reply_to_message_id ~= 0 then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.document then
local File_Id = Message_Reply.content.document.document.remote.id
local Name_File = Message_Reply.content.document.file_name
if tonumber(Name_File:match('(%d+)')) ~= tonumber(Jack) then 
return LuaTele.sendText(msg_chat_id,msg_id,'• عذرا هذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه')
end -- end Namefile
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..File_Id)) 
local download_ = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,''..Name_File) 
local Get_Info = io.open(download_,"r"):read('*a')
local All_Groups = JSON.decode(Get_Info)
if All_Groups.GP_BOT then
for idg,v in pairs(All_Groups.GP_BOT) do
redis:sadd(Jack.."group:ids",idg) 
if v.MNSH then
for k,idmsh in pairs(v.MNSH) do
redis:sadd(Jack.."Jack:Originators:Group"..idg,idmsh)
end;end
if v.MDER then
for k,idmder in pairs(v.MDER) do
redis:sadd(Jack.."Jack:Managers:Group"..idg,idmder)  
end;end
if v.MOD then
for k,idmod in pairs(v.MOD) do
redis:sadd(Jack.."Jack:Addictive:Group"..idg,idmod)
end;end
if v.ASAS then
for k,idASAS in pairs(v.ASAS) do
redis:sadd(Jack..":MONSHA_Groupp:"..idg,idASAS)
end;end
end
return LuaTele.sendText(msg_chat_id,msg_id,'• تم استرجاع المجموعات من نسخه جاك')
else
return LuaTele.sendText(msg_chat_id,msg_id,'• الملف لا يدعم هذا البوت')
end
end
end

if text == 'تحديث السورس' or text == 'تحديث السورس' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
os.execute('rm -rf Jack.lua')
download('https://raw.githubusercontent.com/bandarr005/t/main/Jack.lua','Jack.lua')
return LuaTele.sendText(msg_chat_id,msg_id,'\n• تم تحديث السورس  ')  
end
if text == 'تع الاذاعه' or text == 'تعطيل الاذاعه' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:SendBcBot") 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل الاذاعه ","md",true)
end
if text == 'تعطيل الاذاعه' or text == 'تفعيل الاذاعه' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:SendBcBot",true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل الاذاعه للمطورين ","md",true)
end

if text == 'قفل ردود MY'  then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."lock_reda") 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل الردود ","md",true)
end
if text == 'فتح ردود MY'  then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."lock_reda",true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل الردود للمطورين ","md",true)
end
if text == 'تعطيل المغادره' or text == 'تعطيل المغادره' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:LeftBot") 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل المغادره ","md",true)
end
if text == 'تفعيل المغادره' or text == 'تفعيل المغادره' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:LeftBot",true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل المغادره للمطورين ","md",true)
end
if (redis:get(Jack.."Jack:AddSudosNew"..msg_chat_id) == 'true') then
if text == "الغاء" or text == 'الغاء الامر' then   
redis:del(Jack.."Jack:AddSudosNew"..msg_chat_id)
return LuaTele.sendText(msg_chat_id,msg_id, "\n• تم الغاء امر تغيير المطور الاساسي","md",true)    
end 
redis:del(Jack.."Jack:AddSudosNew"..msg_chat_id)
if text and text:match("^@[%a%d_]+$") then
local UserId_Info = LuaTele.searchPublicChat(text)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف قناة او قروب ","md",true)  
end
if UserName and UserName[2]:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف البوت ","md",true)  
end
local Informationlua = io.open("Information.lua", 'w')
Informationlua:write([[
return {
Token = "]]..Token..[[",
UserBot = "]]..UserBot..[[",
UserSudo = "]]..text:gsub('@','')..[[",
SudoId = ]]..UserId_Info.id..[[
}
]])
Informationlua:close()
return LuaTele.sendText(msg_chat_id,msg_id,"\n• تم تغيير المطور الاساسي اصبح على : [@"..text:gsub('@','').."]","md",true)  
end
end
if text == 'تغيير م' or text == 'تغيير م' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:AddSudosNew"..msg_chat_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل معرف المطور الاساسي مع @","md",true)
end
if text == 'جلب النسخه الاحتياطيه' or text == 'جلب نسخه احتياطيه' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
local Groups = redis:smembers(Jack..'group:ids')  
local UsersBot = redis:smembers(Jack..'users')  
local Get_Json = '{"BotId": '..Jack..','  
if #UsersBot ~= 0 then 
Get_Json = Get_Json..'"UsersBot":['  
for k,v in pairs(UsersBot) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..']'
end
Get_Json = Get_Json..',"GroupsBot":{'
for k,v in pairs(Groups) do   
local President = redis:smembers(Jack..":MONSHA_Groupp:"..v)
local Constructor = redis:smembers(Jack.."Jack:Originators:Group"..v)
local Manager = redis:smembers(Jack.."Jack:Managers:Group"..v)
local Admin = redis:smembers(Jack.."Jack:Addictive:Group"..v)
local Vips = redis:smembers(Jack.."Jack:Distinguished:Group"..v)
if k == 1 then
Get_Json = Get_Json..'"'..v..'":{'
else
Get_Json = Get_Json..',"'..v..'":{'
end
if #President ~= 0 then 
Get_Json = Get_Json..'"President":['
for k,v in pairs(President) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Constructor ~= 0 then
Get_Json = Get_Json..'"Constructor":['
for k,v in pairs(Constructor) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Manager ~= 0 then
Get_Json = Get_Json..'"Manager":['
for k,v in pairs(Manager) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Admin ~= 0 then
Get_Json = Get_Json..'"Admin":['
for k,v in pairs(Admin) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Vips ~= 0 then
Get_Json = Get_Json..'"Vips":['
for k,v in pairs(Vips) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
Get_Json = Get_Json..'"Dev":"LILIILILIIIL"}'
end
Get_Json = Get_Json..'}}'
local File = io.open('./'..UserBot..'.json', "w")
File:write(Get_Json)
File:close()
return LuaTele.sendDocument(msg_chat_id,msg_id,'./'..UserBot..'.json', '• تم جلب النسخه الاحتياطيه\n• تحتوي على '..#Groups..' مجموعه \n• وتحتوي على '..#UsersBot..' مشترك \n', "md")
end
if text and text:match("^تعين عدد الاعضاء (%d+)$") then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack..'Jack:Num:Add:Bot',text:match("تعين عدد الاعضاء (%d+)$") ) 
LuaTele.sendText(msg_chat_id,msg_id,'•  تم تعيين عدد اعضاء تفعيل البوت اكثر من : '..text:match("تعين عدد الاعضاء (%d+)$")..' عضو ',"md",true)  
elseif text =='الاحصائيات' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
LuaTele.sendText(msg_chat_id,msg_id,'• عدد احصائيات البوت الكامله \n━━━━━━━━━━━━\n• عدد المجموعات : '..(redis:scard(Jack..'group:ids') or 0)..'\n• عدد المشتركين : '..(redis:scard(Jack..'users') or 0)..'',"md",true)  
end
if text == 'تفعيل' and msg.Developers then
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if redis:sismember(Jack.."group:ids",msg_chat_id) then
if tonumber(Info_Chats.member_count) < tonumber((redis:get(Jack..'Jack:Num:Add:Bot') or 0)) and not msg.ControllerBot then
return LuaTele.sendText(msg_chat_id,msg_id,'• عدد الاعضاء قليل لا يمكن تفعيل المجموعه  يجب ان يكوم اكثر من :'..redis:get(Jack..'Jack:Num:Add:Bot'),"md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'\n• المجموعه : ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')\n• تم تفعيلها مسبقا ',"md",true)  
else
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- رفع المالك والادمنيه', data = msg.sender.user_id..'/addAdmins@'..msg_chat_id},
},
{
{text = '- قفل جميع الاوامر ', data =msg.sender.user_id..'/LockAllGroup@'..msg_chat_id},
},
}
}
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- مغادرة المجموعه ', data = '/leftgroup@'..msg_chat_id}, 
},
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
LuaTele.sendText(Sudo_Id,0,'\n• تم تفعيل مجموعه جديده \n• من قام بتفعيلها : ['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..') \n• معلومات المجموعه :\n• عدد الاعضاء : '..Info_Chats.member_count..'\n• عدد الادمنيه : '..Info_Chats.administrator_count..'\n• عدد المطرودين : '..Info_Chats.banned_count..'\n🔕︙عدد المقيدين : '..Info_Chats.restricted_count..'',"md",true, false, false, false, reply_markup)
end
redis:sadd(Jack.."group:ids",msg_chat_id)
redis:set(Jack.."lock_id"..msg_chat_id,true) ;redis:set(Jack.."Jack:Status:Reply"..msg_chat_id,true) ;redis:set(Jack.."Jack:Status:ReplySudo"..msg_chat_id,true) ;redis:set(Jack.."Jack:Status:BanId"..msg_chat_id,true) ;redis:set(Jack.."Jack:Status:SetId"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• المجموعه : ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')\n• تم تفعيل المجموعه ',"md", true, false, false, false, reply_markup)
end
end 
if text == 'تفعيل' and not msg.Developers then
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
local AddedBot = true
elseif (StatusMember == "chatMemberStatusAdministrator") then
local AddedBot = true
else
local AddedBot = false
end
if AddedBot == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرا انته لست ادمن او مالك المجموعه ","md",true)  
end
if not redis:get(Jack.."Jack:BotFree") then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• الوضع الخدمي تم تعطيله من قبل مطور البوت ","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if redis:sismember(Jack.."group:ids",msg_chat_id) then
if tonumber(Info_Chats.member_count) < tonumber((redis:get(Jack..'Jack:Num:Add:Bot') or 0)) and not msg.ControllerBot then
return LuaTele.sendText(msg_chat_id,msg_id,'• عدد الاعضاء قليل لا يمكن تفعيل المجموعه  يجب ان يكوم اكثر من :'..redis:get(Jack..'Jack:Num:Add:Bot'),"md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'\n• المجموعه : ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')\n• تم تفعيلها مسبقا ',"md",true)  
else
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- مغادرة المجموعه ', data = '/leftgroup@'..msg_chat_id}, 
},
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
LuaTele.sendText(Sudo_Id,0,'\n• تم تفعيل مجموعه جديده \n• من قام بتفعيلها : ['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..') \n• معلومات المجموعه :\n• عدد الاعضاء : '..Info_Chats.member_count..'\n• عدد الادمنيه : '..Info_Chats.administrator_count..'\n• عدد المطرودين : '..Info_Chats.banned_count..'\n🔕︙عدد المقيدين : '..Info_Chats.restricted_count..'',"md",true, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- رفع المالك والادمنيه', data = msg.sender.user_id..'/addAdmins@'..msg_chat_id},
},
{
{text = '- قفل جميع الاوامر ', data =msg.sender.user_id..'/LockAllGroup@'..msg_chat_id},
},
}
}
redis:sadd(Jack.."group:ids",msg_chat_id)
redis:set(Jack.."lock_id"..msg_chat_id,true) ;redis:set(Jack.."Jack:Status:Reply"..msg_chat_id,true) ;redis:set(Jack.."Jack:Status:ReplySudo"..msg_chat_id,true) ;redis:set(Jack.."Jack:Status:BanId"..msg_chat_id,true) ;redis:set(Jack.."Jack:Status:SetId"..msg_chat_id,true) ;redis:set(Jack.."Jack:Status:IdPhoto"..msg_chat_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,'\n• المجموعه : ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')\n• تم تفعيل المجموعه ',"md", true, false, false, false, reply_markup)
end
end

if text == 'تعطيل' and msg.Developers then
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if not redis:sismember(Jack.."group:ids",msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• المجموعه : ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')\n• تم تعطيلها مسبقا ',"md",true)  
else
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
LuaTele.sendText(Sudo_Id,0,'\n• تم تعطيل مجموعه جديده \n• من قام بتعطيلها : ['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..') \n• معلومات المجموعه :\n• عدد الاعضاء : '..Info_Chats.member_count..'\n• عدد الادمنيه : '..Info_Chats.administrator_count..'\n• عدد المطرودين : '..Info_Chats.banned_count..'\n🔕︙عدد المقيدين : '..Info_Chats.restricted_count..'',"md",true, false, false, false, reply_markup)
end
redis:srem(Jack.."group:ids",msg_chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,'\n• المجموعه : ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')\n• تم تعطيلها بنجاح ',"md",true)
end
end
if text == 'تعطيل' and not msg.Developers then
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
local AddedBot = true
elseif (StatusMember == "chatMemberStatusAdministrator") then
local AddedBot = true
else
local AddedBot = false
end
if AddedBot == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذرا انته لست ادمن او مالك المجموعه ","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if not redis:sismember(Jack.."group:ids",msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• المجموعه : ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')\n• تم تعطيلها مسبقا ',"md",true)  
else
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
LuaTele.sendText(Sudo_Id,0,'\n• تم تعطيل مجموعه جديده \n• من قام بتعطيلها : ['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..') \n• معلومات المجموعه :\n• عدد الاعضاء : '..Info_Chats.member_count..'\n• عدد الادمنيه : '..Info_Chats.administrator_count..'\n• عدد المطرودين : '..Info_Chats.banned_count..'\n• عدد المقيدين : '..Info_Chats.restricted_count..'',"md",true, false, false, false, reply_markup)
end
redis:srem(Jack.."group:ids",msg_chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,'\n• المجموعه : ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')\n• تم تعطيلها بنجاح ',"md",true)
end
end
if chat_type(msg.chat_id) == "GroupBot" and redis:sismember(Jack.."group:ids",msg_chat_id) then
if text == '@all' then
local Info_Members = LuaTele.searchChatMembers(msg_chat_id, "*", 200)
x = 0 
tags = 0 
local list = Info_Members.members 
for k, v in pairs(list) do 
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.username ~= "" then
if x == 2 or x == tags or k == 0 then 
tags = x + 2 
t = "#all" 
end 
x = x + 1 
t = t..", ["..UserInfo.first_name.."](t.me/"..UserInfo.username..")" 
if x == 2 or x == tags or k == 0 then 
local Text = t:gsub('#all,','#all\n') 
local msg_id = msg.id/2097152/0.5 
https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown") 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
end
end
end
if text == "ايدي" and msg.reply_to_message_id == 0 then
if not redis:get(Jack.."lock_id"..msg_chat_id) then
return false
end
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local photo = LuaTele.getUserProfilePhotos(msg.sender.user_id)
local UserId = msg.sender.user_id
local RinkBot = msg.TheRankCmd
local TotalMsg = redis:get(Jack..'msgs:'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalPhoto = photo.total_count or 0
local TotalEdit = redis:get(Jack..'Jack:Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local TotalMsgT = Total_message(TotalMsg) 
local NumberGames = redis:get(Jack.."Jack:Num:Add:Games"..msg.chat_id..msg.sender.user_id) or 0
local NumAdd = redis:get(Jack.."Jack:Num:Add:Memp"..msg.chat_id..":"..msg.sender.user_id) or 0
local Texting = {'ملاك وناسيك بقروبنه😟',"حلغوم والله☹️ ","اطلق صوره🐼❤️","كيكك والله🥺","لازك بيها غيرها عاد😒",}
local Description = Texting[math.random(#Texting)]
if UserInfo.username then
UserInfousername = '@'..UserInfo.username..''
else
UserInfousername = 'لا يوجد'
end
local infouser = https.request("https://api.telegram.org/bot"..Token.."/getChat?chat_id="..msg.sender.user_id)
local info_ = JSON.decode(infouser)
if info_.result.bio then
biouser = info_.result.bio
else
biouser = 'لا يوجد '
end
local Ctitle = https.request("https://api.telegram.org/bot"..Token.."/getChatMember?chat_id="..msg_chat_id.."&user_id="..msg.sender.user_id)
local info_ = JSON.decode(Ctitle)
if info_.result.status == "administrator" and info_.result.custom_title or info_.result.status == "creator" and info_.result.custom_title then
lakbk = info_.result.custom_title
else
lakbk = 'لا يوجد'
end
Get_Is_Id = redis:get(Jack.."Jack:Set:Id:Groups") or redis:get(Jack.."Jack:Set:Id:Group"..msg_chat_id)
if redis:get(Jack.."Jack:Status:IdPhoto"..msg_chat_id) then
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#الجهات',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#الايدي',msg.sender.user_id) 
local Get_Is_Id = Get_Is_Id:gsub('#اليوزر',UserInfousername) 
local Get_Is_Id = Get_Is_Id:gsub('#الرسائل',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#التعديل',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#الرتبه',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('#التفاعل',TotalMsgT) 
local Get_Is_Id = Get_Is_Id:gsub('#التعليقات',Description) 
local Get_Is_Id = Get_Is_Id:gsub('#النقاط',NumberGames) 
local Get_Is_Id = Get_Is_Id:gsub('#الصور',TotalPhoto) 
if photo.total_count > 0 then
return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,Get_Is_Id)
else
return LuaTele.sendText(msg_chat_id,msg_id,Get_Is_Id,"md",true) 
end
else
if photo.total_count > 0 then
return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,
'\n • '..RandomText()..
'\n• ID : '..UserId..
'\n• USE : '..UserInfousername..
'\n• STE : '..RinkBot..
'\n• MSG : '..TotalMsg..
'\n• EDIT : '..TotalEdit..
'\n• GG : '..TotalMsgT..
'\n• bio : '..biouser..
'\n• Tile : '..lakbk..
'') 
else
return LuaTele.sendText(msg_chat_id,msg_id,
'\n• ايديك : '..UserId..
'\n• معرفك : '..UserInfousername..
'\n• رتبتك : '..RinkBot..
'\n• رسائلك : '..TotalMsg..
'\n• تعديلاتك : '..TotalEdit..
'\n• تفاعلك : '..TotalMsgT..
'') 
end
end
else
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#الجهات',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#الايدي',msg.sender.user_id) 
local Get_Is_Id = Get_Is_Id:gsub('#اليوزر',UserInfousername) 
local Get_Is_Id = Get_Is_Id:gsub('#الرسائل',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#التعديل',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#الرتبه',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('#التفاعل',TotalMsgT) 
local Get_Is_Id = Get_Is_Id:gsub('#التعليقات',Description) 
local Get_Is_Id = Get_Is_Id:gsub('#النقاط',NumberGames) 
local Get_Is_Id = Get_Is_Id:gsub('#الصور',TotalPhoto) 
return LuaTele.sendText(msg_chat_id,msg_id,'['..Get_Is_Id..']',"md",true) 
else
return LuaTele.sendText(msg_chat_id,msg_id,
'\n• ايديك : '..UserId..
'\n• معرفك : '..UserInfousername..
'\n• رتبتك : '..RinkBot..
'\n• رسائلك : '..TotalMsg..
'\n• تعديلاتك : '..TotalEdit..
'\n• تفاعلك : '..TotalMsgT..
'') 
end
end
end
if text == 'ايدي' or text == 'كشف'  and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.username then
UserInfousername = '@'..UserInfo.username..''
else
UserInfousername = 'لا يوجد'
end
local UserId = Message_Reply.sender.user_id
local RinkBot = Controller(msg_chat_id,UserId)
local TotalMsg = redis:get(Jack..'msgs:'..msg_chat_id..':'..UserId) or 0
local TotalEdit = redis:get(Jack..'Jack:Num:Message:Edit'..msg_chat_id..UserId) or 0
local TotalMsgT = Total_message(TotalMsg) 
local NumAdd = redis:get(Jack.."Jack:Num:Add:Memp"..msg.chat_id..":"..UserId) or 0
local NumberGames = redis:get(Jack.."Jack:Num:Add:Games"..msg.chat_id..UserId) or 0
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#الجهات',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#الايدي',UserId) 
local Get_Is_Id = Get_Is_Id:gsub('#اليوزر',UserInfousername) 
local Get_Is_Id = Get_Is_Id:gsub('#الرسائل',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#التعديل',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#الرتبه',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('#التفاعل',TotalMsgT)  
local Get_Is_Id = Get_Is_Id:gsub('#النقاط',NumberGames) 
return LuaTele.sendText(msg_chat_id,msg_id,Get_Is_Id,"md",true) 
else
return LuaTele.sendText(msg_chat_id,msg_id,
'\n• ايديه : '..UserId..
'\n• معرفه : '..UserInfousername..
'\n▽‍︙رتبته : '..RinkBot..
'\n• رسائله : '..TotalMsg..
'\n• تعديلاته : '..TotalEdit..
'\n• تفاعله : '..TotalMsgT..
'') 
end
end
if text and text:match('^ايدي @(%S+)$') or text and text:match('^كشف @(%S+)$') then
local UserName = text:match('^ايدي @(%S+)$') or text:match('^كشف @(%S+)$')
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف قناة او قروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف البوت ","md",true)  
end
local UserId = UserId_Info.id
local RinkBot = Controller(msg_chat_id,UserId_Info.id)
local TotalMsg = redis:get(Jack..'msgs:'..msg_chat_id..':'..UserId) or 0
local TotalEdit = redis:get(Jack..'Jack:Num:Message:Edit'..msg_chat_id..UserId) or 0
local TotalMsgT = Total_message(TotalMsg) 
local NumAdd = redis:get(Jack.."Jack:Num:Add:Memp"..msg.chat_id..":"..UserId) or 0
local NumberGames = redis:get(Jack.."Jack:Num:Add:Games"..msg.chat_id..UserId) or 0
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#الجهات',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#الايدي',UserId) 
local Get_Is_Id = Get_Is_Id:gsub('#اليوزر','@'..UserName) 
local Get_Is_Id = Get_Is_Id:gsub('#الرسائل',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#التعديل',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#الرتبه',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('#التفاعل',TotalMsgT)  
local Get_Is_Id = Get_Is_Id:gsub('#النقاط',NumberGames) 
return LuaTele.sendText(msg_chat_id,msg_id,Get_Is_Id,"md",true) 
else
return LuaTele.sendText(msg_chat_id,msg_id,
'\n• ايديه : '..UserId..
'\n• معرفه : @'..UserName..
'\n▽‍︙رتبته : '..RinkBot..
'\n• رسائله : '..TotalMsg..
'\n• تعديلاته : '..TotalEdit..
'\n• تفاعله : '..TotalMsgT..
'') 
end
end
if text == 'رتبتي' then

return LuaTele.sendText(msg_chat_id,msg_id,'\n• رتبتك هي : '..msg.TheRankCmd,"md",true)  
end
if text == 'معلوماتي' or text == 'موقعي' then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
var(LuaTele.getChatMember(msg_chat_id,msg.sender.user_id))
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
StatusMemberChat = 'مالك المجموعه'
elseif (StatusMember == "chatMemberStatusAdministrator") then
StatusMemberChat = 'مشرف المجموعه'
else
StatusMemberChat = 'عضو في المجموعه'
end
local UserId = msg.sender.user_id
local RinkBot = msg.TheRankCmd
local TotalMsg = redis:get(Jack..'msgs:'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalEdit = redis:get(Jack..'Jack:Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local TotalMsgT = Total_message(TotalMsg) 
if UserInfo.username then
UserInfousername = '@'..UserInfo.username..''
else
UserInfousername = 'لا يوجد'
end
if StatusMemberChat == 'مشرف المجموعه' then 
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status
if GetMemberStatus.can_change_info then
change_info = '〖  نعم 〗' else change_info = '〖  لا 〗'
end
if GetMemberStatus.can_delete_messages then
delete_messages = '〖  نعم 〗' else delete_messages = '〖  لا 〗'
end
if GetMemberStatus.can_invite_users then
invite_users = '〖  نعم 〗' else invite_users = '〖  لا 〗'
end
if GetMemberStatus.can_pin_messages then
pin_messages = '〖  نعم 〗' else pin_messages = '〖  لا 〗'
end
if GetMemberStatus.can_restrict_members then
restrict_members = '〖  نعم 〗' else restrict_members = '〖  لا 〗'
end
if GetMemberStatus.can_promote_members then
promote = '〖  نعم 〗' else promote = '〖  لا 〗'
end
PermissionsUser = '\n• صلاحيات المستخدم :\n━━━━━━━━━━━━'..'\n• تغيير المعلومات : '..change_info..'\n• تثبيت الرسائل : '..pin_messages..'\n• اضافه مستخدمين : '..invite_users..'\n• مسح الرسائل : '..delete_messages..'\n• حظر المستخدمين : '..restrict_members..'\n• اضافه المشرفين : '..promote..'\n\n'
end
return LuaTele.sendText(msg_chat_id,msg_id,
'\n• ايديك : '..UserId..
'\n• معرفك : '..UserInfousername..
'\n▽‍︙رتبتك : '..RinkBot..
'\n▽‍︙رتبته المجموعه: '..StatusMemberChat..
'\n• رسائلك : '..TotalMsg..
'\n• تعديلاتك : '..TotalEdit..
'\n• تفاعلك : '..TotalMsgT..
''..(PermissionsUser or '')) 
end
if text == 'كشف البوت' then 
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
local StatusMember = LuaTele.getChatMember(msg_chat_id,Jack).status.luatele
if (StatusMember ~= "chatMemberStatusAdministrator") then
return LuaTele.sendText(msg_chat_id,msg_id,'• البوت عضو في المجموعه ',"md",true) 
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,Jack).status
if GetMemberStatus.can_change_info then
change_info = '〖  نعم 〗' else change_info = '〖  لا 〗'
end
if GetMemberStatus.can_delete_messages then
delete_messages = '〖  نعم 〗' else delete_messages = '〖  لا 〗'
end
if GetMemberStatus.can_invite_users then
invite_users = '〖  نعم 〗' else invite_users = '〖  لا 〗'
end
if GetMemberStatus.can_pin_messages then
pin_messages = '〖  نعم 〗' else pin_messages = '〖  لا 〗'
end
if GetMemberStatus.can_restrict_members then
restrict_members = '〖  نعم 〗' else restrict_members = '〖  لا 〗'
end
if GetMemberStatus.can_promote_members then
promote = '〖  نعم 〗' else promote = '〖  لا 〗'
end
PermissionsUser = '\n• صلاحيات البوت في المجموعه :\n━━━━━━━━━━━━'..'\n• تغيير المعلومات : '..change_info..'\n• تثبيت الرسائل : '..pin_messages..'\n• اضافه مستخدمين : '..invite_users..'\n• مسح الرسائل : '..delete_messages..'\n• حظر المستخدمين : '..restrict_members..'\n• اضافه المشرفين : '..promote..'\n\n'
return LuaTele.sendText(msg_chat_id,msg_id,PermissionsUser,"md",true) 
end

if text and text:match('^مسح (%d+)$') then
local NumMessage = text:match('^مسح (%d+)$')
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).Delmsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه حذف الرسائل ',"md",true)  
end
if tonumber(NumMessage) > 1000 then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• العدد اكثر من 1000 لا تستطيع الحذف',"md",true)  
end
local Message = msg.id
for i=1,tonumber(NumMessage) do
local deleteMessages = LuaTele.deleteMessages(msg.chat_id,{[1]= Message})
var(deleteMessages)
Message = Message - 1048576
end
LuaTele.sendText(msg_chat_id, msg_id, "• تم مسح - "..NumMessage.. ' رساله', "md")
end

if text and text:match('^تنزيل (.*) @(%S+)$') then
local UserName = {text:match('^تنزيل (.*) @(%S+)$')}
local UserId_Info = LuaTele.searchPublicChat(UserName[2])
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف قناة او قروب ","md",true)  
end
if UserName and UserName[2]:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف البوت ","md",true)  
end
if UserName[1] == "مطور ثانوي" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
if not redis:sismember(Jack.."Jack:DevelopersQ:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله مطور ثانوي مسبقا ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:DevelopersQ:Groups",UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله مطور ثانوي").Reply,"md",true)  
end
end
if UserName[1] == "مطور" then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(2)..' 〗 فقط . ',"md",true)  
end
if not redis:sismember(Jack.."Jack:Developers:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله مطور مسبقا ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:Developers:Groups",UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله مطور ").Reply,"md",true)  
end
end
if UserName[1] == "مالك" then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(3)..' 〗 فقط . ',"md",true)  
end
if not redis:sismember(Jack..":MONSHA_Group:"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله مالك مسبقا ").Reply,"md",true)  
else
redis:srem(Jack..":MONSHA_Group:"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله مالك ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ اساسي" then
if not msg.TheBasicsm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(44)..' 〗 فقط . ',"md",true)  
end
if not redis:sismember(Jack..":MONSHA_Groupp:"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله منشئ اساسي مسبقا ").Reply,"md",true)  
else
redis:srem(Jack..":MONSHA_Groupp:"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله منشئ اساسي ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ" then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(4)..' 〗 فقط . ',"md",true)  
end
if not redis:sismember(Jack.."Jack:Originators:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله من المنشئين مسبقا ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:Originators:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله من المنشئين ").Reply,"md",true)  
end
end
if UserName[1] == "مدير" then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(5)..' 〗 فقط . ',"md",true)  
end
if not redis:sismember(Jack.."Jack:Managers:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله من المدراء مسبقا ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:Managers:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله من المدراء ").Reply,"md",true)  
end
end
if UserName[1] == "ادمن" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
if not redis:sismember(Jack.."Jack:Addictive:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله من الادمنيه مسبقا ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:Addictive:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله من الادمنيه ").Reply,"md",true)  
end
end
if UserName[1] == "مميز" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if not redis:sismember(Jack.."Jack:Distinguished:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله من المميزين مسبقا ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:Distinguished:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله من المميزين ").Reply,"md",true)  
end
end
end

if text and text:match("^تنزيل (.*)$") and msg.reply_to_message_id ~= 0 then
local TextMsg = text:match("^تنزيل (.*)$")
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على البوت ","md",true)  
end
if TextMsg == 'مطور ثانوي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
if not redis:sismember(Jack.."Jack:DevelopersQ:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله مطور ثانوي مسبقا ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:DevelopersQ:Groups",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله مطور ثانوي").Reply,"md",true)  
end
end
if TextMsg == 'مطور' then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(2)..' 〗 فقط . ',"md",true)  
end
if not redis:sismember(Jack.."Jack:Developers:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله مطور مسبقا ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:Developers:Groups",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله مطور ").Reply,"md",true)  
end
end
if TextMsg == "مالك" then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(3)..' 〗 فقط . ',"md",true)  
end
if not redis:sismember(Jack..":MONSHA_Group:"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله مالك مسبقا ").Reply,"md",true)  
else
redis:srem(Jack..":MONSHA_Group:"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله مالك ").Reply,"md",true)  
end
end
if TextMsg == "منشئ اساسي" then
if not msg.TheBasicsm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(44)..' 〗 فقط . ',"md",true)  
end
if not redis:sismember(Jack..":MONSHA_Groupp:"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله منشئ اساسي مسبقا ").Reply,"md",true)  
else
redis:srem(Jack..":MONSHA_Groupp:"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله منشئ اساسي ").Reply,"md",true)  
end
end
if TextMsg == "منشئ" then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(4)..' 〗 فقط . ',"md",true)  
end
if not redis:sismember(Jack.."Jack:Originators:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله من المنشئين مسبقا ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:Originators:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله من المنشئين ").Reply,"md",true)  
end
end
if TextMsg == "مدير" then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(5)..' 〗 فقط . ',"md",true)  
end
if not redis:sismember(Jack.."Jack:Managers:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله من المدراء مسبقا ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:Managers:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله من المدراء ").Reply,"md",true)  
end
end
if TextMsg == "ادمن" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
if not redis:sismember(Jack.."Jack:Addictive:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله من الادمنيه مسبقا ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:Addictive:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله من الادمنيه ").Reply,"md",true)  
end
end
if TextMsg == "مميز" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if not redis:sismember(Jack.."Jack:Distinguished:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله من المميزين مسبقا ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:Distinguished:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله من المميزين ").Reply,"md",true)  
end
end
end


if text and text:match('^تنزيل (.*) (%d+)$') then
local UserId = {text:match('^تنزيل (.*) (%d+)$')}
local UserInfo = LuaTele.getUser(UserId[2])
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على البوت ","md",true)  
end
if UserId[1] == 'مطور ثانوي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
if not redis:sismember(Jack.."Jack:DevelopersQ:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم تنزيله مطور ثانوي مسبقا ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:DevelopersQ:Groups",UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم تنزيله مطور ثانوي").Reply,"md",true)  
end
end
if UserId[1] == 'مطور' then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(2)..' 〗 فقط . ',"md",true)  
end
if not redis:sismember(Jack.."Jack:Developers:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم تنزيله مطور مسبقا ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:Developers:Groups",UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم تنزيله مطور ").Reply,"md",true)  
end
end
if UserId[1] == "مالك" then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(3)..' 〗 فقط . ',"md",true)  
end
if not redis:sismember(Jack..":MONSHA_Group:"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم تنزيله مالك مسبقا ").Reply,"md",true)  
else
redis:srem(Jack..":MONSHA_Group:"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم تنزيله مالك ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ اساسي" then
if not msg.TheBasicsm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(44)..' 〗 فقط . ',"md",true)  
end
if not redis:sismember(Jack..":MONSHA_Groupp:"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم تنزيله منشئ اساسي مسبقا ").Reply,"md",true)  
else
redis:srem(Jack..":MONSHA_Groupp:"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم تنزيله منشئ اساسي ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ" then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(4)..' 〗 فقط . ',"md",true)  
end
if not redis:sismember(Jack.."Jack:Originators:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم تنزيله من المنشئين مسبقا ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:Originators:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم تنزيله من المنشئين ").Reply,"md",true)  
end
end
if UserId[1] == "مدير" then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(5)..' 〗 فقط . ',"md",true)  
end
if not redis:sismember(Jack.."Jack:Managers:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم تنزيله من المدراء مسبقا ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:Managers:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم تنزيله من المدراء ").Reply,"md",true)  
end
end
if UserId[1] == "ادمن" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
if not redis:sismember(Jack.."Jack:Addictive:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم تنزيله من الادمنيه مسبقا ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:Addictive:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم تنزيله من الادمنيه ").Reply,"md",true)  
end
end
if UserId[1] == "مميز" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if not redis:sismember(Jack.."Jack:Distinguished:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم تنزيله من المميزين مسبقا ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:Distinguished:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم تنزيله من المميزين ").Reply,"md",true)  
end
end
end
if text and text:match('^رفع (.*) @(%S+)$') then
local UserName = {text:match('^رفع (.*) @(%S+)$')}
local UserId_Info = LuaTele.searchPublicChat(UserName[2])
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف قناة او قروب ","md",true)  
end
if UserName and UserName[2]:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف البوت ","md",true)  
end
if UserName[1] == "مطور ثانوي" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
if redis:sismember(Jack.."Jack:DevelopersQ:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته مطور ثانوي مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:DevelopersQ:Groups",UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته مطور ثانوي").Reply,"md",true)  
end
end
if UserName[1] == "مطور" then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(2)..' 〗 فقط . ',"md",true)  
end
if redis:sismember(Jack.."Jack:Developers:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته مطور مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:Developers:Groups",UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته مطور ").Reply,"md",true)  
end
end
if UserName[1] == "مالك" then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(3)..' 〗 فقط . ',"md",true)  
end
if redis:sismember(Jack..":MONSHA_Group:"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته مالك مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack..":MONSHA_Group:"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته مالك ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ اساسي" then
if not msg.TheBasicsm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(44)..' 〗 فقط . ',"md",true)  
end
if redis:sismember(Jack..":MONSHA_Groupp:"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته منشئ اساسي مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack..":MONSHA_Groupp:"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته منشئ اساسي ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ" then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(4)..' 〗 فقط . ',"md",true)  
end
if redis:sismember(Jack.."Jack:Originators:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته منشئ  مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:Originators:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته منشئ  ").Reply,"md",true)  
end
end
if UserName[1] == "مدير" then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(5)..' 〗 فقط . ',"md",true)  
end
if redis:sismember(Jack.."Jack:Managers:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته مدير  مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:Managers:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته مدير  ").Reply,"md",true)  
end
end
if UserName[1] == "ادمن" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
if not msg.Originators and not redis:get(Jack.."Jack:Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if redis:sismember(Jack.."Jack:Addictive:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته ادمن  مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:Addictive:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته ادمن  ").Reply,"md",true)  
end
end
if UserName[1] == "مميز" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if not msg.Originators and not redis:get(Jack.."Jack:Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if redis:sismember(Jack.."Jack:Distinguished:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته مميز  مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:Distinguished:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم ترقيته مميز  ").Reply,"md",true)  
end
end
end
if text and text:match("^رفع (.*)$") and msg.reply_to_message_id ~= 0 then
local TextMsg = text:match("^رفع (.*)$")
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على البوت ","md",true)  
end
if TextMsg == 'مطور ثانوي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
if redis:sismember(Jack.."Jack:DevelopersQ:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته مطور ثانوي مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:DevelopersQ:Groups",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته مطور ثانوي").Reply,"md",true)  
end
end
if TextMsg == 'مطور' then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(2)..' 〗 فقط . ',"md",true)  
end
if redis:sismember(Jack.."Jack:Developers:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته مطور مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:Developers:Groups",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته مطور ").Reply,"md",true)  
end
end
if TextMsg == "مالك" then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(3)..' 〗 فقط . ',"md",true)  
end
if redis:sismember(Jack..":MONSHA_Group:"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته مالك مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack..":MONSHA_Group:"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته مالك ").Reply,"md",true)  
end
end
if TextMsg == "منشئ اساسي" then
if not msg.TheBasicsm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(44)..' 〗 فقط . ',"md",true)  
end
if redis:sismember(Jack..":MONSHA_Groupp:"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته منشئ اساسي مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack..":MONSHA_Groupp:"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته منشئ اساسي ").Reply,"md",true)  
end
end
if TextMsg == "منشئ" then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(4)..' 〗 فقط . ',"md",true)  
end
if redis:sismember(Jack.."Jack:Originators:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته منشئ  مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:Originators:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته منشئ  ").Reply,"md",true)  
end
end
if TextMsg == "مدير" then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(5)..' 〗 فقط . ',"md",true)  
end
if redis:sismember(Jack.."Jack:Managers:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته مدير  مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:Managers:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته مدير  ").Reply,"md",true)  
end
end
if TextMsg == "ادمن" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
if not msg.Originators and not redis:get(Jack.."Jack:Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if redis:sismember(Jack.."Jack:Addictive:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته ادمن  مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:Addictive:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته ادمن  ").Reply,"md",true)  
end
end
if TextMsg == "مميز" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if not msg.Originators and not redis:get(Jack.."Jack:Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if redis:sismember(Jack.."Jack:Distinguished:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته مميز  مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:Distinguished:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم ترقيته مميز  ").Reply,"md",true)  
end
end
end
if text and text:match('^رفع (.*) (%d+)$') then
local UserId = {text:match('^رفع (.*) (%d+)$')}
local UserInfo = LuaTele.getUser(UserId[2])
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على البوت ","md",true)  
end
if UserId[1] == 'مطور ثانوي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
if redis:sismember(Jack.."Jack:DevelopersQ:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم ترقيته مطور ثانوي مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:DevelopersQ:Groups",UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم ترقيته مطور ثانوي").Reply,"md",true)  
end
end
if UserId[1] == 'مطور' then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(2)..' 〗 فقط . ',"md",true)  
end
if redis:sismember(Jack.."Jack:Developers:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم ترقيته مطور مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:Developers:Groups",UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم ترقيته مطور ").Reply,"md",true)  
end
end
if UserId[1] == "مالك" then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(3)..' 〗 فقط . ',"md",true)  
end
if redis:sismember(Jack..":MONSHA_Group:"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم ترقيته مالك مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack..":MONSHA_Group:"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم ترقيته مالك ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ اساسي" then
if not msg.TheBasicsm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(44)..' 〗 فقط . ',"md",true)  
end
if redis:sismember(Jack..":MONSHA_Groupp:"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم ترقيته منشئ اساسي مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack..":MONSHA_Groupp:"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم ترقيته منشئ اساسي ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ" then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(4)..' 〗 فقط . ',"md",true)  
end
if redis:sismember(Jack.."Jack:Originators:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم ترقيته منشئ  مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:Originators:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم ترقيته منشئ  ").Reply,"md",true)  
end
end
if UserId[1] == "مدير" then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(5)..' 〗 فقط . ',"md",true)  
end
if redis:sismember(Jack.."Jack:Managers:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم ترقيته مدير  مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:Managers:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم ترقيته مدير  ").Reply,"md",true)  
end
end
if UserId[1] == "ادمن" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
if not msg.Originators and not redis:get(Jack.."Jack:Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if redis:sismember(Jack.."Jack:Addictive:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم ترقيته ادمن  مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:Addictive:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم ترقيته ادمن  ").Reply,"md",true)  
end
end
if UserId[1] == "مميز" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if not msg.Originators and not redis:get(Jack.."Jack:Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if redis:sismember(Jack.."Jack:Distinguished:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم ترقيته مميز  مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:Distinguished:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2],"• تم ترقيته مميز  ").Reply,"md",true)  
end
end
end
if text and text:match("^تغير رد المطور (.*)$") then
local Teext = text:match("^تغير رد المطور (.*)$") 
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Developer:Bot:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id,"•  تم تغير رد المطور الى :"..Teext)
elseif text and text:match("^تغير رد المنشئ الاساسي (.*)$") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
local Teext = text:match("^تغير رد المنشئ الاساسي (.*)$") 
redis:set(Jack.."Jack:President:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id,"•  تم تغير رد المنشئ الاساسي الى :"..Teext)
elseif text and text:match("^تغير رد المنشئ (.*)$") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
local Teext = text:match("^تغير رد المنشئ (.*)$") 
redis:set(Jack.."Jack:Constructor:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id,"•  تم تغير رد المنشئ الى :"..Teext)
elseif text and text:match("^تغير رد المالك (.*)$") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
local Teext = text:match("^تغير رد المالك (.*)$") 
redis:set(Jack.."Jack:PresidentQ:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id,"•  تم تغير رد المالك الى :"..Teext)
elseif text and text:match("^تغير رد المدير (.*)$") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
local Teext = text:match("^تغير رد المدير (.*)$") 
redis:set(Jack.."Jack:Manager:Group:Reply"..msg.chat_id,Teext) 
return LuaTele.sendText(msg_chat_id,msg_id,"•  تم تغير رد المدير الى :"..Teext)
elseif text and text:match("^تغير رد الادمن (.*)$") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
local Teext = text:match("^تغير رد الادمن (.*)$") 
redis:set(Jack.."Jack:Admin:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id,"•  تم تغير رد الادمن الى :"..Teext)
elseif text and text:match("^تغير رد المميز (.*)$") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
local Teext = text:match("^تغير رد المميز (.*)$") 
redis:set(Jack.."Jack:Vip:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id,"•  تم تغير رد المميز الى :"..Teext)
elseif text and text:match("^تغير رد العضو (.*)$") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
local Teext = text:match("^تغير رد العضو (.*)$") 
redis:set(Jack.."Jack:Mempar:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id,"•  تم تغير رد العضو الى :"..Teext)
elseif text == 'حذف رد المطور' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Developer:Bot:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حدف رد المطور")
elseif text == 'حذف رد المنشئ الاساسي' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:President:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حذف رد المنشئ الاساسي ")
elseif text == 'حذف رد المالك' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:PresidentQ:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حذف رد المالك ")
elseif text == 'حذف رد المنشئ' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Constructor:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حذف رد المنشئ ")
elseif text == 'حذف رد المدير' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Manager:Group:Reply"..msg.chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حذف رد المدير ")
elseif text == 'حذف رد الادمن' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Admin:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حذف رد الادمن ")
elseif text == 'حذف رد المميز' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Vip:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حذف رد المميز")
elseif text == 'حذف رد العضو' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Mempar:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حذف رد العضو")
end
if text == 'المطورين الثانويين' or text == 'المطورين الثانوين' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack.."Jack:DevelopersQ:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مطورين حاليا , ","md",true)  
end
ListMembers = '\n• قائمه مطورين الثانويين \n ━━━━━━━━━━━━\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المطورين الثانويين', data = msg.sender.user_id..'/DevelopersQ'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, "md", false, false, false, false, reply_markup)
end
if text == 'المطورين' then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(2)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack.."Jack:Developers:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مطورين حاليا , ","md",true)  
end
ListMembers = '\n• قائمه مطورين البوت \n ━━━━━━━━━━━━\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المطورين', data = msg.sender.user_id..'/Developers'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, "md", false, false, false, false, reply_markup)
end
if text == 'المالكين' then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(3)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack..":MONSHA_Group:"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مالكين حاليا , ","md",true)  
end
ListMembers = '\n• قائمه المالكين \n ━━━━━━━━━━━━\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المالكين', data = msg.sender.user_id..'/TheBasicsQ'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, "md", false, false, false, false, reply_markup)
end
if text == 'المنشئين الاساسيين' then
if not msg.TheBasicsm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(44)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack..":MONSHA_Groupp:"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد منشئين اساسيين حاليا , ","md",true)  
end
ListMembers = '\n• قائمه المنشئين الاساسيين \n ━━━━━━━━━━━━\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المنشئين الاساسيين', data = msg.sender.user_id..'/TheBasics'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, "md", false, false, false, false, reply_markup)
end
if text == 'المنشئين' then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(4)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack.."Jack:Originators:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد منشئين حاليا , ","md",true)  
end
ListMembers = '\n• قائمه المنشئين  \n ━━━━━━━━━━━━\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المنشئين', data = msg.sender.user_id..'/Originators'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, "md", false, false, false, false, reply_markup)
end
if text == 'المدراء' then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(5)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack.."Jack:Managers:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مدراء حاليا , ","md",true)  
end
ListMembers = '\n• قائمه المدراء  \n ━━━━━━━━━━━━\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المدراء', data = msg.sender.user_id..'/Managers'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, "md", false, false, false, false, reply_markup)
end
if text == 'الادمنيه' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack.."Jack:Addictive:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد ادمنيه حاليا , ","md",true)  
end
ListMembers = '\n• قائمه الادمنيه  \n ━━━━━━━━━━━━\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الادمنيه', data = msg.sender.user_id..'/Addictive'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, "md", false, false, false, false, reply_markup)
end
if text == 'المميزين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack.."Jack:Distinguished:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مميزين حاليا , ","md",true)  
end
ListMembers = '\n• قائمه المميزين  \n ━━━━━━━━━━━━\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المميزين', data = msg.sender.user_id..'/DelDistinguished'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, "md", false, false, false, false, reply_markup)
end
if text == 'المحظورين عام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack.."Jack:BanAll:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد محظورين عام حاليا , ","md",true)  
end
ListMembers = '\n• قائمه المحظورين عام  \n ━━━━━━━━━━━━\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المحظورين عام', data = msg.sender.user_id..'/BanAll'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, "md", false, false, false, false, reply_markup)
end
if text == 'المكتومين عام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack.."Jack:ktmAll:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مكتومين عام حاليا , ","md",true)  
end
ListMembers = '\n• قائمه المكتومين عام  \n ━━━━━━━━━━━━\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المكتومين عام', data = msg.sender.user_id..'/ktmAll'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, "md", false, false, false, false, reply_markup)
end
if text == 'المحظورين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack.."Jack:BanGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد محظورين حاليا , ","md",true)  
end
ListMembers = '\n• قائمه المحظورين  \n ━━━━━━━━━━━━\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المحظورين', data = msg.sender.user_id..'/BanGroup'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, "md", false, false, false, false, reply_markup)
end
if text == 'المكتومين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack.."Jack:SilentGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مكتومين حاليا , ","md",true)  
end
ListMembers = '\n• قائمه المكتومين  \n ━━━━━━━━━━━━\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المكتومين', data = msg.sender.user_id..'/SilentGroupGroup'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, "md", false, false, false, false, reply_markup)
end
if text and text:match("^تفعيل (.*)$") and msg.reply_to_message_id == 0 then
local TextMsg = text:match("^تفعيل (.*)$")
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if TextMsg == 'الرابط' then
redis:set(Jack.."Jack:Status:Link"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل الرابط ","md",true)
end
if TextMsg == 'الترحيب' then
redis:set(Jack.."Jack:Status:Welcome"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل الترحيب ","md",true)
end
if TextMsg == 'الايدي' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."lock_id"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل الايدي ","md",true)
end
if TextMsg == 'الايدي بالصوره' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Status:IdPhoto"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل الايدي بالصوره ","md",true)
end
if TextMsg == 'ردود المدير' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Status:Reply"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل ردود المدير ","md",true)
end
if TextMsg == 'ردود المطور' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Status:ReplySudo"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل ردود المطور ","md",true)
end
if TextMsg == 'الردود العامه' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."replay"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل الردود العامه ","md",true)
end
if TextMsg == 'الحظر' or TextMsg == 'الطرد' or TextMsg == 'التقييد' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Status:BanId"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل الحظر , الطرد , التقييد","md",true)
end
if TextMsg == 'الرفع' then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(5)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Status:SetId"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل الرفع ","md",true)
end
if TextMsg == 'الالعاب' then
redis:set(Jack.."Jack:Status:Games"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل الالعاب ","md",true)
end
if TextMsg == 'التحقق' then
    redis:set(Jack.."Jack:Status:joinet"..msg_chat_id,true) 
    return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل التحقق ","md",true)
    end
if TextMsg == 'اطردني' then
redis:set(Jack.."Jack:Status:KickMe"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل اطردني ","md",true)
end
if TextMsg == 'نزلني' then
redis:set(Jack.."Jack:Status:remMe"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل نزلني ","md",true)
end
if TextMsg == 'البوت الخدمي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:BotFree",true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل البوت الخدمي ","md",true)
end
if TextMsg == 'التواصل' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:TwaslBot",true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل التواصل داخل البوت ","md",true)
end

end

if text and text:match("^تعطيل (.*)$") and msg.reply_to_message_id == 0 then
local TextMsg = text:match("^تعطيل (.*)$")
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if TextMsg == 'الرابط' then
redis:del(Jack.."Jack:Status:Link"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل الرابط ","md",true)
end
if TextMsg == 'الترحيب' then
redis:del(Jack.."Jack:Status:Welcome"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل الترحيب ","md",true)
end
if TextMsg == 'الايدي' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."lock_id"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل الايدي ","md",true)
end
if TextMsg == 'الايدي بالصوره' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Status:IdPhoto"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل الايدي بالصوره ","md",true)
end
if TextMsg == 'ردود المدير' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Status:Reply"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل ردود المدير ","md",true)
end
if TextMsg == 'ردود المطور' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Status:ReplySudo"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل ردود المطور ","md",true)
end
if TextMsg == 'الحظر' or TextMsg == 'الطرد' or TextMsg == 'التقييد' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Status:BanId"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل الحظر , الطرد , التقييد","md",true)
end
if TextMsg == 'الرفع' then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(5)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Status:SetId"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل الرفع ","md",true)
end
if TextMsg == 'الالعاب' then
redis:del(Jack.."Jack:Status:Games"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل الالعاب ","md",true)
end
if TextMsg == 'التحقق' then
    redis:del(Jack.."Jack:Status:joinet"..msg_chat_id) 
    return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل التحقق ","md",true)
    end
if TextMsg == 'اطردني' then
redis:del(Jack.."Jack:Status:KickMe"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل اطردني ","md",true)
end
if TextMsg == 'نزلني' then
redis:del(Jack.."Jack:Status:remMe"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل نزلني ","md",true)
end
if TextMsg == 'البوت الخدمي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:BotFree") 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل البوت الخدمي ","md",true)
end
if TextMsg == 'التواصل' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:TwaslBot") 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل التواصل داخل البوت ","md",true)
end

end

if text and text:match('^حظر عام @(%S+)$') then
local UserName = text:match('^حظر عام @(%S+)$')
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(2)..' 〗 فقط . ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف قناة او قروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف البوت ","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'Dev🎖' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على  "..Controller(msg_chat_id,UserId_Info.id).."  ","md",true)  
end
if redis:sismember(Jack.."Jack:BanAll:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:BanAll:Groups",UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'banned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم حظره عام من المجموعات ").Reply,"md",true)  
end
end
if text and text:match('^الغاء العام @(%S+)$') then
local UserName = text:match('^الغاء العام @(%S+)$')
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(2)..' 〗 فقط . ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف قناة او قروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف البوت ","md",true)  
end
if not redis:sismember(Jack.."Jack:BanAll:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم الغاء حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:BanAll:Groups",UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم الغاء حظره عام من المجموعات  ").Reply,"md",true)  
end
end
if text and text:match('^كتم عام @(%S+)$') then
local UserName = text:match('^كتم عام @(%S+)$')
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(2)..' 〗 فقط . ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف قناة او قروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف البوت ","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'Dev🎖' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على  "..Controller(msg_chat_id,UserId_Info.id).."  ","md",true)  
end
if redis:sismember(Jack.."Jack:ktmAll:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:ktmAll:Groups",UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم كتمه عام من المجموعات ").Reply,"md",true)  
end
end
if text and text:match('^الغاء كتم العام @(%S+)$') then
local UserName = text:match('^الغاء كتم العام @(%S+)$')
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(2)..' 〗 فقط . ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف قناة او قروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف البوت ","md",true)  
end
if not redis:sismember(Jack.."Jack:ktmAll:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم الغاء كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:ktmAll:Groups",UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم الغاء كتمه عام من المجموعات  ").Reply,"md",true)  
end
end
if text and text:match('^حظر @(%S+)$') then
local UserName = text:match('^حظر @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
if not msg.Originators and not redis:get(Jack.."Jack:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف قناة او قروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على  "..Controller(msg_chat_id,UserId_Info.id).."  ","md",true)  
end
if redis:sismember(Jack.."Jack:BanGroup:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم حظره من المجموعه مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:BanGroup:Group"..msg_chat_id,UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'banned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم حظره من المجموعه ").Reply,"md",true)  
end
end
if text and text:match('^الغاء حظر @(%S+)$') then
local UserName = text:match('^الغاء حظر @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف قناة او قروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف البوت ","md",true)  
end
if not redis:sismember(Jack.."Jack:BanGroup:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم الغاء حظره من المجموعه مسبقا ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:BanGroup:Group"..msg_chat_id,UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم الغاء حظره من المجموعه  ").Reply,"md",true)  
end
end

if text and text:match('^كتم @(%S+)$') then
local UserName = text:match('^كتم @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if GetInfoBot(msg).Delmsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه حذف الرسائل ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف قناة او قروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusSilent(msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على  "..Controller(msg_chat_id,UserId_Info.id).."  ","md",true)  
end
if redis:sismember(Jack.."Jack:SilentGroup:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم كتمه في المجموعه مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:SilentGroup:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم كتمه في المجموعه  ").Reply,"md",true)  
end
end
if text and text:match('^الغاء كتم @(%S+)$') then
local UserName = text:match('^الغاء كتم @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف قناة او قروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف البوت ","md",true)  
end
if not redis:sismember(Jack.."Jack:SilentGroup:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم الغاء كتمه من المجموعه ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:SilentGroup:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم الغاء كتمه من المجموعه ").Reply,"md",true)  
end
end
if text and text:match('^تقييد (%d+) (.*) @(%S+)$') then
local UserName = {text:match('^تقييد (%d+) (.*) @(%S+)$') }
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
if not msg.Originators and not redis:get(Jack.."Jack:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName[3])
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف قناة او قروب ","md",true)  
end
if UserName[3] and UserName[3]:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على  "..Controller(msg_chat_id,UserId_Info.id).."  ","md",true)  
end
if UserName[2] == 'يوم' then
Time_Restrict = UserName[1]:match('(%d+)')
Time = Time_Restrict * 86400
end
if UserName[2] == 'ساعه' then
Time_Restrict = UserName[1]:match('(%d+)')
Time = Time_Restrict * 3600
end
if UserName[2] == 'دقيقه' then
Time_Restrict = UserName[1]:match('(%d+)')
Time = Time_Restrict * 60
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,0,0,0,0,0,0,0,0,tonumber(msg.date+Time)})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تقييده في المجموعه \n• لمدة : "..UserName[1]..' '..UserName[2]).Reply,"md",true)  
end

if text and text:match('^تقييد (%d+) (.*)$') and msg.reply_to_message_id ~= 0 then
local TimeKed = {text:match('^تقييد (%d+) (.*)$') }
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
if not msg.Originators and not redis:get(Jack.."Jack:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على  "..Controller(msg_chat_id,Message_Reply.sender.user_id).."  ","md",true)  
end
if TimeKed[2] == 'يوم' then
Time_Restrict = TimeKed[1]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TimeKed[2] == 'ساعه' then
Time_Restrict = TimeKed[1]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TimeKed[2] == 'دقيقه' then
Time_Restrict = TimeKed[1]:match('(%d+)')
Time = Time_Restrict * 60
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0,tonumber(msg.date+Time)})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تقييده في المجموعه \n• لمدة : "..TimeKed[1]..' '..TimeKed[2]).Reply,"md",true)  
end

if text and text:match('^تقييد (%d+) (.*) (%d+)$') then
local UserId = {text:match('^تقييد (%d+) (.*) (%d+)$') }
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
if not msg.Originators and not redis:get(Jack.."Jack:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserInfo = LuaTele.getUser(UserId[3])
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId[3]) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على  "..Controller(msg_chat_id,UserId[3]).."  ","md",true)  
end
if UserId[2] == 'يوم' then
Time_Restrict = UserId[1]:match('(%d+)')
Time = Time_Restrict * 86400
end
if UserId[2] == 'ساعه' then
Time_Restrict = UserId[1]:match('(%d+)')
Time = Time_Restrict * 3600
end
if UserId[2] == 'دقيقه' then
Time_Restrict = UserId[1]:match('(%d+)')
Time = Time_Restrict * 60
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId[3],'restricted',{1,0,0,0,0,0,0,0,0,tonumber(msg.date+Time)})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[3],"\n• تم تقييده في المجموعه \n• لمدة : "..UserId[1]..' ' ..UserId[2]).Reply,"md",true)  
end
if text and text:match('^تقييد @(%S+)$') then
local UserName = text:match('^تقييد @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if not msg.Originators and not redis:get(Jack.."Jack:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف قناة او قروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على  "..Controller(msg_chat_id,UserId_Info.id).."  ","md",true)  
              end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,0,0,0,0,0,0,0,0})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تقييده في المجموعه ").Reply,"md",true)  
end

if text and text:match('^الغاء التقييد @(%S+)$') then
local UserName = text:match('^الغاء التقييد @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف قناة او قروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف البوت ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم الغاء تقييده من المجموعه").Reply,"md",true)  
end

if text and text:match('^طرد @(%S+)$') then
local UserName = text:match('^طرد @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
if not msg.Originators and not redis:get(Jack.."Jack:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف قناة او قروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على  "..Controller(msg_chat_id,UserId_Info.id).."  ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم طرده من المجموعه ").Reply,"md",true)  
end
if text == ('حظر عام') and msg.reply_to_message_id ~= 0 then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(2)..' 〗 فقط . ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على البوت ","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'Dev🎖' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على  "..Controller(msg_chat_id,Message_Reply.sender.user_id).."  ","md",true)  
end
if redis:sismember(Jack.."Jack:BanAll:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:BanAll:Groups",Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'banned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم حظره عام من المجموعات ").Reply,"md",true)  
end
end
if text == ('الغاء العام') and msg.reply_to_message_id ~= 0 then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(2)..' 〗 فقط . ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not redis:sismember(Jack.."Jack:BanAll:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم الغاء حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:BanAll:Groups",Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم الغاء حظره عام من المجموعات  ").Reply,"md",true)  
end
end
if text == ('كتم عام') and msg.reply_to_message_id ~= 0 then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(2)..' 〗 فقط . ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على البوت ","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'Dev🎖' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على  "..Controller(msg_chat_id,Message_Reply.sender.user_id).."  ","md",true)  
end
if redis:sismember(Jack.."Jack:ktmAll:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:ktmAll:Groups",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم كتمه عام من المجموعات ").Reply,"md",true)  
end
end
if text == ('الغاء كتم العام') and msg.reply_to_message_id ~= 0 then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(2)..' 〗 فقط . ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not redis:sismember(Jack.."Jack:ktmAll:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم الغاء كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:ktmAll:Groups",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم الغاء كتمه عام من المجموعات  ").Reply,"md",true)  
end
end
if text == ('حظر') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
if not msg.Originators and not redis:get(Jack.."Jack:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على  "..Controller(msg_chat_id,Message_Reply.sender.user_id).."  ","md",true)  
end
if redis:sismember(Jack.."Jack:BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم حظره من المجموعه مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'banned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم حظره من المجموعه ").Reply,"md",true)  
end
end
if text == ('الغاء حظر') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not redis:sismember(Jack.."Jack:BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم الغاء حظره من المجموعه مسبقا ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم الغاء حظره من المجموعه  ").Reply,"md",true)  
end
end

if text == ('كتم') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if GetInfoBot(msg).Delmsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه حذف الرسائل ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusSilent(msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على  "..Controller(msg_chat_id,Message_Reply.sender.user_id).."  ","md",true)  
end
if redis:sismember(Jack.."Jack:SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم كتمه في المجموعه مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم كتمه في المجموعه  ").Reply,"md",true)  
end
end
if text == ('الغاء كتم') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not redis:sismember(Jack.."Jack:SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم الغاء كتمه من المجموعه ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم الغاء كتمه من المجموعه ").Reply,"md",true)  
end
end

if text == ('تقييد') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
if not msg.Originators and not redis:get(Jack.."Jack:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على  "..Controller(msg_chat_id,Message_Reply.sender.user_id).."  ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تقييده في المجموعه ").Reply,"md",true)  
end

if text == ('الغاء التقييد') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على البوت ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم الغاء تقييده من المجموعه").Reply,"md",true)  
end

if text == ('طرد') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
if not msg.Originators and not redis:get(Jack.."Jack:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على  "..Controller(msg_chat_id,Message_Reply.sender.user_id).."  ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم طرده من المجموعه ").Reply,"md",true)  
end

if text and text:match('^حظر عام (%d+)$') then
local UserId = text:match('^حظر عام (%d+)$')
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(2)..' 〗 فقط . ',"md",true)  
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end 
if Controller(msg_chat_id,UserId) == 'Dev🎖' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على  "..Controller(msg_chat_id,UserId).."  ","md",true)  
end
if redis:sismember(Jack.."Jack:BanAll:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:BanAll:Groups",UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'banned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم حظره عام من المجموعات ").Reply,"md",true)  
end
end
if text and text:match('^الغاء العام (%d+)$') then
local UserId = text:match('^الغاء العام (%d+)$')
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(2)..' 〗 فقط . ',"md",true)  
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not redis:sismember(Jack.."Jack:BanAll:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم الغاء حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:BanAll:Groups",UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم الغاء حظره عام من المجموعات  ").Reply,"md",true)  
end
end
if text and text:match('^كتم عام (%d+)$') then
local UserId = text:match('^كتم عام (%d+)$')
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(2)..' 〗 فقط . ',"md",true)  
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end 
if Controller(msg_chat_id,UserId) == 'Dev🎖' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على  "..Controller(msg_chat_id,UserId).."  ","md",true)  
end
if redis:sismember(Jack.."Jack:ktmAll:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:ktmAll:Groups",UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم كتمه عام من المجموعات ").Reply,"md",true)  
end
end
if text and text:match('^الغاء كتم العام (%d+)$') then
local UserId = text:match('^الغاء كتم العام (%d+)$')
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(2)..' 〗 فقط . ',"md",true)  
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not redis:sismember(Jack.."Jack:ktmAll:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم الغاء كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:ktmAll:Groups",UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم الغاء كتمه عام من المجموعات  ").Reply,"md",true)  
end
end
if text and text:match('^حظر (%d+)$') then
local UserId = text:match('^حظر (%d+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
if not msg.Originators and not redis:get(Jack.."Jack:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على  "..Controller(msg_chat_id,UserId).."  ","md",true)  
end
if redis:sismember(Jack.."Jack:BanGroup:Group"..msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم حظره من المجموعه مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:BanGroup:Group"..msg_chat_id,UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'banned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم حظره من المجموعه ").Reply,"md",true)  
end
end
if text and text:match('^الغاء حظر (%d+)$') then
local UserId = text:match('^الغاء حظر (%d+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not redis:sismember(Jack.."Jack:BanGroup:Group"..msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم الغاء حظره من المجموعه مسبقا ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:BanGroup:Group"..msg_chat_id,UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم الغاء حظره من المجموعه  ").Reply,"md",true)  
end
end

if text and text:match('^كتم (%d+)$') then
local UserId = text:match('^كتم (%d+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if GetInfoBot(msg).Delmsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه حذف الرسائل ',"md",true)  
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusSilent(msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على  "..Controller(msg_chat_id,UserId).."  ","md",true)  
end
if redis:sismember(Jack.."Jack:SilentGroup:Group"..msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم كتمه في المجموعه مسبقا ").Reply,"md",true)  
else
redis:sadd(Jack.."Jack:SilentGroup:Group"..msg_chat_id,UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم كتمه في المجموعه  ").Reply,"md",true)  
end
end
if text and text:match('^الغاء كتم (%d+)$') then
local UserId = text:match('^الغاء كتم (%d+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not redis:sismember(Jack.."Jack:SilentGroup:Group"..msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم الغاء كتمه من المجموعه ").Reply,"md",true)  
else
redis:srem(Jack.."Jack:SilentGroup:Group"..msg_chat_id,UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم الغاء كتمه من المجموعه ").Reply,"md",true)  
end
end

if text and text:match('^تقييد (%d+)$') then
local UserId = text:match('^تقييد (%d+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
if not msg.Originators and not redis:get(Jack.."Jack:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على  "..Controller(msg_chat_id,UserId).."  ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,0,0,0,0,0,0,0,0})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم تقييده في المجموعه ").Reply,"md",true)  
end

if text and text:match('^الغاء التقييد (%d+)$') then
local UserId = text:match('^الغاء التقييد (%d+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم الغاء تقييده من المجموعه").Reply,"md",true)  
end

if text and text:match('^طرد (%d+)$') then
local UserId = text:match('^طرد (%d+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
if not msg.Originators and not redis:get(Jack.."Jack:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على  "..Controller(msg_chat_id,UserId).."  ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"• تم طرده من المجموعه ").Reply,"md",true)  
end
if text == "نزلني" then
if not redis:get(Jack.."Jack:Status:remMe"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• امر نزلني تم تعطيله من قبل المدراء ","md",true)  
end
if The_ControllerAll(msg.sender.user_id) == true then
Rink = 1
elseif redis:sismember(Jack.."Jack:DevelopersQ:Groups",msg.sender.user_id)  then
Rink = 2
elseif redis:sismember(Jack.."Jack:Developers:Groups",msg.sender.user_id)  then
Rink = 3
elseif redis:sismember(Jack..":MONSHA_Group:"..msg_chat_id, msg.sender.user_id) then
Rink = 4
elseif redis:sismember(Jack..":MONSHA_Groupp:"..msg_chat_id, msg.sender.user_id) then
Rink = 5
elseif redis:sismember(Jack.."Jack:Originators:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 6
elseif redis:sismember(Jack.."Jack:Managers:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 7
elseif redis:sismember(Jack.."Jack:Addictive:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 8
elseif redis:sismember(Jack.."Jack:Distinguished:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 9
else
Rink = 10
end
if Rink == 10 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• ليس لديك رتب عزيزي ","md",true)  
end
if Rink <= 7  then
return LuaTele.sendText(msg_chat_id,msg_id,"• استطيع تنزيل الادمنيه والمميزين فقط","md",true) 
else
redis:srem(Jack.."Jack:Addictive:Group"..msg_chat_id, msg.sender.user_id)
redis:srem(Jack.."Jack:Distinguished:Group"..msg_chat_id, msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تنزيلك من الادمنيه والمميزين ","md",true) 
end
end

if text == "اطردني" or text == "طردني" then
if not redis:get(Jack.."Jack:Status:KickMe"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• امر اطردني تم تعطيله من قبل المدراء ","md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
if StatusCanOrNotCan(msg_chat_id,msg.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على  "..Controller(msg_chat_id,msg.sender.user_id).."  ","md",true)  
end
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
KickMe = true
elseif (StatusMember == "chatMemberStatusAdministrator") then
KickMe = true
else
KickMe = false
end
if KickMe == true then
return LuaTele.sendText(msg_chat_id,msg_id,"• عذرا لا استطيع طرد ادمنيه ومنشئين المجموعه","md",true)    
end
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم طردك من المجموعه بنائآ على طلبك").Reply,"md",true)  
end

if text == 'ادمنيه القروب' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
listAdmin = '\n• قائمه الادمنيه \n ━━━━━━━━━━━━\n'
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Creator = '→  المالك '
else
Creator = ""
end
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.username ~= "" then
listAdmin = listAdmin..""..k.." - @"..UserInfo.username.." "..Creator.."\n"
else
listAdmin = listAdmin..""..k.." - ["..UserInfo.id.."](tg://user?id="..UserInfo.id..") "..Creator.."\n"
end
end
LuaTele.sendText(msg_chat_id,msg_id,listAdmin,"md",true)  
end
if text == 'رفع الادمنيه' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
y = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].bot_info == nil then
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
redis:sadd(Jack..":MONSHA_Groupp:"..msg_chat_id,v.member_id.user_id) 
x = x + 1
else
redis:sadd(Jack.."Jack:Addictive:Group"..msg_chat_id,v.member_id.user_id) 
y = y + 1
end
end
end
LuaTele.sendText(msg_chat_id,msg_id,'\n• تم ترقيه - ('..y..') ادمنيه ',"md",true)  
end

if text == 'المالك' then
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.first_name == "" then
LuaTele.sendText(msg_chat_id,msg_id,"• اوبس , المالك حسابه محذوف ","md",true)  
return false
end
if UserInfo.username then
Creator = "• مالك المجموعه : @"..UserInfo.username.."\n"
else
Creator = "• مالك المجموعه : ["..UserInfo.first_name.."](tg://user?id="..UserInfo.id..")\n"
end
return LuaTele.sendText(msg_chat_id,msg_id,Creator,"md",true)  
end
end
end


if text == 'كشف البوتات' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Bots", "*", 0, 200)
local List_Members = Info_Members.members
listBots = '\n• قائمه البوتات \n ━━━━━━━━━━━━\n'
x = 0
for k, v in pairs(List_Members) do
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if Info_Members.members[k].status.luatele == "chatMemberStatusAdministrator" then
x = x + 1
Admin = '→  ادمن '
else
Admin = ""
end
listBots = listBots..""..k.." - @"..UserInfo.username.." "..Admin.."\n"
end
LuaTele.sendText(msg_chat_id,msg_id,listBots.."\n━━━━━━━━━━━━\n• عدد البوتات التي هي ادمن ( "..x.." )","md",true)  
end


 
if text == 'المقيدين' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Recent", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
y = nil
restricted = '\n• قائمه المقيديين \n ━━━━━━━━━━━━\n'
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.is_member == true and Info_Members.members[k].status.luatele == "chatMemberStatusRestricted" then
y = true
x = x + 1
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.username ~= "" then
restricted = restricted..""..x.." - @"..UserInfo.username.."\n"
else
restricted = restricted..""..x.." - ["..UserInfo.id.."](tg://user?id="..UserInfo.id..") \n"
end
end
end
if y == true then
LuaTele.sendText(msg_chat_id,msg_id,restricted,"md",true)  
end
end


if text == "غادر" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(3)..' 〗 فقط . ',"md",true)  
end
if not msg.ControllerBot and not redis:set(Jack.."Jack:LeftBot") then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• امر المغادره معطل من قبل الاساسي ',"md",true)  
end
LuaTele.sendText(msg_chat_id,msg_id,"\n• تم مغادرة المجموعه بامر من المطور ","md",true)  
local Left_Bot = LuaTele.leaveChat(msg.chat_id)
end
if text == 'تاك للكل' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
local Info_Members = LuaTele.searchChatMembers(msg_chat_id, "*", 200)
local List_Members = Info_Members.members
listall = '\n• قائمه الاعضاء \n ━━━━━━━━━━━━\n'
for k, v in pairs(List_Members) do
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.username ~= "" then
listall = listall..""..k.." - @"..UserInfo.username.."\n"
else
listall = listall..""..k.." - ["..UserInfo.id.."](tg://user?id="..UserInfo.id..")\n"
end
end
LuaTele.sendText(msg_chat_id,msg_id,listall)  
end

if text == "قفل الدردشه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:text"..msg_chat_id,true) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الدردشه").Lock,"md",true)  
return false
end 
if text == "قفل الاضافه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:AddMempar"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل اضافة الاعضاء").Lock,"md",true)  
return false
end 
if text == "قفل الدخول" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Join"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل دخول الاعضاء").Lock,"md",true)  
return false
end 
if text == "قفل البوتات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Bot:kick"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل البوتات").Lock,"md",true)  
return false
end 
if text == "قفل البوتات بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Bot:kick"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل البوتات").lockKick,"md",true)  
return false
end 
if text == "قفل الاشعارات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:tagservr"..msg_chat_id,true)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الاشعارات").Lock,"md",true)  
return false
end 
if text == "قفل التثبيت" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:lockpin"..msg_chat_id,(LuaTele.getChatPinnedMessage(msg_chat_id).id or true)) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل التثبيت هنا").Lock,"md",true)  
return false
end 
if text == "قفل التعديل" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:edit"..msg_chat_id,true) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل تعديل").Lock,"md",true)  
return false
end 
if text == "قفل تعديل الميديا" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:edit"..msg_chat_id,true) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل تعديل").Lock,"md",true)  
return false
end 
if text == "قفل الكل" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:tagservrbot"..msg_chat_id,true)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
redis:set(Jack..'Jack:'..lock..msg_chat_id,"del")    
end
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل جميع الاوامر").Lock,"md",true)  
return false
end 


--------------------------------------------------------------------------------------------------------------
if text == "فتح الاضافه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Lock:AddMempar"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح اضافة الاعضاء").unLock,"md",true)  
return false
end 
if text == "فتح الدردشه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Lock:text"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الدردشه").unLock,"md",true)  
return false
end 
if text == "فتح الدخول" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Lock:Join"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح دخول الاعضاء").unLock,"md",true)  
return false
end 
if text == "فتح البوتات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Lock:Bot:kick"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح البوتات").unLock,"md",true)  
return false
end 
if text == "فتح البوتات " then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Lock:Bot:kick"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح البوتات").unLock,"md",true)  
return false
end 
if text == "فتح الاشعارات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Lock:tagservr"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الاشعارات").unLock,"md",true)  
return false
end 
if text == "فتح التثبيت" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:lockpin"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح التثبيت هنا").unLock,"md",true)  
return false
end 
if text == "فتح التعديل" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Lock:edit"..msg_chat_id) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح تعديل").unLock,"md",true)  
return false
end 
if text == "فتح التعديل الميديا" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Lock:edit"..msg_chat_id) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح تعديل").unLock,"md",true)  
return false
end 
if text == "فتح الكل" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Lock:tagservrbot"..msg_chat_id)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
redis:del(Jack..'Jack:'..lock..msg_chat_id)    
end
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح جميع الاوامر").unLock,"md",true)  
return false
end 
--------------------------------------------------------------------------------------------------------------
if text == "قفل التكرار" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:hset(Jack.."Jack:Spam:Group:User"..msg_chat_id ,"Spam:User","del")  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل التكرار").Lock,"md",true)  
elseif text == "قفل التكرار بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:hset(Jack.."Jack:Spam:Group:User"..msg_chat_id ,"Spam:User","keed")  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل التكرار").lockKid,"md",true)  
elseif text == "قفل التكرار بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:hset(Jack.."Jack:Spam:Group:User"..msg_chat_id ,"Spam:User","mute")  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل التكرار").lockKtm,"md",true)  
elseif text == "قفل التكرار بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:hset(Jack.."Jack:Spam:Group:User"..msg_chat_id ,"Spam:User","kick")  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل التكرار").lockKick,"md",true)  
elseif text == "فتح التكرار" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:hdel(Jack.."Jack:Spam:Group:User"..msg_chat_id ,"Spam:User")  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح التكرار").unLock,"md",true)  
end
if text == "قفل الروابط" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Link"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الروابط").Lock,"md",true)  
return false
end 
if text == "قفل الروابط بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Link"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الروابط").lockKid,"md",true)  
return false
end 
if text == "قفل الروابط بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Link"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الروابط").lockKtm,"md",true)  
return false
end 
if text == "قفل الروابط بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Link"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الروابط").lockKick,"md",true)  
return false
end 
if text == "فتح الروابط" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Lock:Link"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الروابط").unLock,"md",true)  
return false
end 
if text == "قفل المعرفات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:User:Name"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل المعرفات").Lock,"md",true)  
return false
end 
if text == "قفل المعرفات بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:User:Name"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل المعرفات").lockKid,"md",true)  
return false
end 
if text == "قفل المعرفات بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:User:Name"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل المعرفات").lockKtm,"md",true)  
return false
end 
if text == "قفل المعرفات بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:User:Name"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل المعرفات").lockKick,"md",true)  
return false
end 
if text == "فتح المعرفات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Lock:User:Name"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح المعرفات").unLock,"md",true)  
return false
end 
if text == "قفل التاك" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:hashtak"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل التاك").Lock,"md",true)  
return false
end 
if text == "قفل التاك بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:hashtak"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل التاك").lockKid,"md",true)  
return false
end 
if text == "قفل التاك بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:hashtak"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل التاك").lockKtm,"md",true)  
return false
end 
if text == "قفل التاك بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:hashtak"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل التاك").lockKick,"md",true)  
return false
end 
if text == "فتح التاك" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Lock:hashtak"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح التاك").unLock,"md",true)  
return false
end 
if text == "قفل الشارحه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Cmd"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الشارحه").Lock,"md",true)  
return false
end 
if text == "قفل الشارحه بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Cmd"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الشارحه").lockKid,"md",true)  
return false
end 
if text == "قفل الشارحه بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Cmd"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الشارحه").lockKtm,"md",true)  
return false
end 
if text == "قفل الشارحه بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Cmd"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الشارحه").lockKick,"md",true)  
return false
end 
if text == "فتح الشارحه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Lock:Cmd"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الشارحه").unLock,"md",true)  
return false
end 
if text == "قفل الصور"then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Photo"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الصور").Lock,"md",true)  
return false
end 
if text == "قفل الصور بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Photo"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الصور").lockKid,"md",true)  
return false
end 
if text == "قفل الصور بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Photo"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الصور").lockKtm,"md",true)  
return false
end 
if text == "قفل الصور بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Photo"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الصور").lockKick,"md",true)  
return false
end 
if text == "فتح الصور" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Lock:Photo"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الصور").unLock,"md",true)  
return false
end 
if text == "قفل الفيديو" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Video"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الفيديو").Lock,"md",true)  
return false
end 
if text == "قفل الفيديو بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Video"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الفيديو").lockKid,"md",true)  
return false
end 
if text == "قفل الفيديو بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Video"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الفيديو").lockKtm,"md",true)  
return false
end 
if text == "قفل الفيديو بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Video"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الفيديو").lockKick,"md",true)  
return false
end 
if text == "فتح الفيديو" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Lock:Video"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الفيديو").unLock,"md",true)  
return false
end 
if text == "قفل المتحركه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Animation"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل المتحركه").Lock,"md",true)  
return false
end 
if text == "قفل المتحركه بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Animation"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل المتحركه").lockKid,"md",true)  
return false
end 
if text == "قفل المتحركه بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Animation"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل المتحركه").lockKtm,"md",true)  
return false
end 
if text == "قفل المتحركه بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Animation"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل المتحركه").lockKick,"md",true)  
return false
end 
if text == "فتح المتحركه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Lock:Animation"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح المتحركه").unLock,"md",true)  
return false
end 
if text == "قفل الالعاب" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:geam"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الالعاب").Lock,"md",true)  
return false
end 
if text == "قفل الالعاب بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:geam"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الالعاب").lockKid,"md",true)  
return false
end 
if text == "قفل الالعاب بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:geam"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الالعاب").lockKtm,"md",true)  
return false
end 
if text == "قفل الالعاب بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:geam"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الالعاب").lockKick,"md",true)  
return false
end 
if text == "فتح الالعاب" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Lock:geam"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الالعاب").unLock,"md",true)  
return false
end 
if text == "قفل الاغاني" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Audio"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الاغاني").Lock,"md",true)  
return false
end 
if text == "قفل الاغاني بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Audio"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الاغاني").lockKid,"md",true)  
return false
end 
if text == "قفل الاغاني بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Audio"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الاغاني").lockKtm,"md",true)  
return false
end 
if text == "قفل الاغاني بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Audio"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الاغاني").lockKick,"md",true)  
return false
end 
if text == "فتح الاغاني" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Lock:Audio"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الاغاني").unLock,"md",true)  
return false
end 
if text == "قفل الصوت" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:vico"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الصوت").Lock,"md",true)  
return false
end 
if text == "قفل الصوت بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:vico"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الصوت").lockKid,"md",true)  
return false
end 
if text == "قفل الصوت بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:vico"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الصوت").lockKtm,"md",true)  
return false
end 
if text == "قفل الصوت بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:vico"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الصوت").lockKick,"md",true)  
return false
end 
if text == "فتح الصوت" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Lock:vico"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الصوت").unLock,"md",true)  
return false
end 
if text == "قفل الكيبورد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Keyboard"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الكيبورد").Lock,"md",true)  
return false
end 
if text == "قفل الكيبورد بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Keyboard"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الكيبورد").lockKid,"md",true)  
return false
end 
if text == "قفل الكيبورد بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Keyboard"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الكيبورد").lockKtm,"md",true)  
return false
end 
if text == "قفل الكيبورد بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Keyboard"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الكيبورد").lockKick,"md",true)  
return false
end 
if text == "فتح الكيبورد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Lock:Keyboard"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الكيبورد").unLock,"md",true)  
return false
end 
if text == "قفل الملصقات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Sticker"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الملصقات").Lock,"md",true)  
return false
end 
if text == "قفل الملصقات بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Sticker"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الملصقات").lockKid,"md",true)  
return false
end 
if text == "قفل الملصقات بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Sticker"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الملصقات").lockKtm,"md",true)  
return false
end 
if text == "قفل الملصقات بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Sticker"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الملصقات").lockKick,"md",true)  
return false
end 
if text == "فتح الملصقات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Lock:Sticker"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الملصقات").unLock,"md",true)  
return false
end 
if text == "قفل التوجيه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:forward"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل التوجيه").Lock,"md",true)  
return false
end 
if text == "قفل التوجيه بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:forward"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل التوجيه").lockKid,"md",true)  
return false
end 
if text == "قفل التوجيه بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:forward"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل التوجيه").lockKtm,"md",true)  
return false
end 
if text == "قفل التوجيه بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:forward"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل التوجيه").lockKick,"md",true)  
return false
end 
if text == "فتح التوجيه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Lock:forward"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح التوجيه").unLock,"md",true)  
return false
end 
if text == "قفل الملفات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Document"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الملفات").Lock,"md",true)  
return false
end 
if text == "قفل الملفات بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Document"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الملفات").lockKid,"md",true)  
return false
end 
if text == "قفل الملفات بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Document"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الملفات").lockKtm,"md",true)  
return false
end 
if text == "قفل الملفات بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Document"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الملفات").lockKick,"md",true)  
return false
end 
if text == "فتح الملفات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Lock:Document"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الملفات").unLock,"md",true)  
return false
end 
if text == "قفل السيلفي" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Unsupported"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل السيلفي").Lock,"md",true)  
return false
end 
if text == "قفل السيلفي بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Unsupported"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل السيلفي").lockKid,"md",true)  
return false
end 
if text == "قفل السيلفي بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Unsupported"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل السيلفي").lockKtm,"md",true)  
return false
end 
if text == "قفل السيلفي بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Unsupported"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل السيلفي").lockKick,"md",true)  
return false
end 
if text == "فتح السيلفي" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Lock:Unsupported"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح السيلفي").unLock,"md",true)  
return false
end 
if text == "قفل الماركداون" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Markdaun"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الماركداون").Lock,"md",true)  
return false
end 
if text == "قفل الماركداون بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Markdaun"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الماركداون").lockKid,"md",true)  
return false
end 
if text == "قفل الماركداون بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Markdaun"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الماركداون").lockKtm,"md",true)  
return false
end 
if text == "قفل الماركداون بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Markdaun"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الماركداون").lockKick,"md",true)  
return false
end 
if text == "فتح الماركداون" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Lock:Markdaun"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الماركداون").unLock,"md",true)  
return false
end 
if text == "قفل الجهات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Contact"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الجهات").Lock,"md",true)  
return false
end 
if text == "قفل الجهات بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Contact"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الجهات").lockKid,"md",true)  
return false
end 
if text == "قفل الجهات بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Contact"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الجهات").lockKtm,"md",true)  
return false
end 
if text == "قفل الجهات بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Contact"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الجهات").lockKick,"md",true)  
return false
end 
if text == "فتح الجهات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Lock:Contact"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الجهات").unLock,"md",true)  
return false
end 
if text == "قفل الكلايش" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Spam"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الكلايش").Lock,"md",true)  
return false
end 
if text == "قفل الكلايش بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Spam"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الكلايش").lockKid,"md",true)  
return false
end 
if text == "قفل الكلايش بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Spam"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الكلايش").lockKtm,"md",true)  
return false
end 
if text == "قفل الكلايش بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Spam"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الكلايش").lockKick,"md",true)  
return false
end 
if text == "فتح الكلايش" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Lock:Spam"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الكلايش").unLock,"md",true)  
return false
end 
if text == "قفل الانلاين" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Inlen"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الانلاين").Lock,"md",true)  
return false
end 
if text == "قفل الانلاين بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Inlen"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الانلاين").lockKid,"md",true)  
return false
end 
if text == "قفل الانلاين بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Inlen"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الانلاين").lockKtm,"md",true)  
return false
end 
if text == "قفل الانلاين بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Lock:Inlen"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم قفل الانلاين").lockKick,"md",true)  
return false
end 
if text == "فتح الانلاين" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Lock:Inlen"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"• تم فتح الانلاين").unLock,"md",true)  
return false
end 
if text == "ضع رابط" or text == "وضع رابط" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:setex(Jack.."Jack:Set:Link"..msg_chat_id..""..msg.sender.user_id,120,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل رابط المجموعه او رابط قناة المجموعه","md",true)  
end
if text == "مسح الرابط" or text == "حذف الرابط" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Group:Link"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم مسح الرابط ","md",true)             
end
if text == "الرابط" then
if not redis:get(Jack.."Jack:Status:Link"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل جلب الرابط من قبل الادمنيه","md",true)
end 
local Get_Chat = LuaTele.getChat(msg_chat_id)
local GetLink = redis:get(Jack.."Jack:Group:Link"..msg_chat_id) 
if GetLink then
Text = '['..Get_Chat.title.. ']('..GetLink..')'
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown") 
else 
local LinkGroup = LuaTele.generateChatInviteLink(msg_chat_id,'taha',tonumber(msg.date+86400),0,true)
if LinkGroup.code == 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا استطيع جلب الرابط بسبب ليس لدي صلاحيه دعوه مستخدمين من خلال الرابط ","md",true)
end
Text = '['..Get_Chat.title.. ']('..LinkGroup.invite_link..')'
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown") 
end
end



if text == "ضع ترحيب" or text == "وضع ترحيب" then  
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:setex(Jack.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id, 120, true)  
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل لي الترحيب الان".."\n• تستطيع اضافة مايلي !\n• دالة عرض الاسم »`name`\n• دالة عرض المعرف »`user`\n• دالة عرض اسم المجموعه »`NameCh`","md",true)   
end
if text == "الترحيب" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if not redis:get(Jack.."Jack:Status:Welcome"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل الترحيب من قبل الادمنيه","md",true)
end 
local Welcome = redis:get(Jack.."Jack:Welcome:Group"..msg_chat_id)
if Welcome then 
return LuaTele.sendText(msg_chat_id,msg_id,Welcome,"md",true)   
else 
return LuaTele.sendText(msg_chat_id,msg_id,"• لم يتم تعيين ترحيب للمجموعه","md",true)   
end 
end
if text == "مسح الترحيب" or text == "حذف الترحيب" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Welcome:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم ازالة ترحيب المجموعه","md",true)   
end
if text == "ضع قوانين" or text == "وضع قوانين" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:setex(Jack.."Jack:Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل لي القوانين الان","md",true)  
end
if text == "مسح القوانين" or text == "حذف القوانين" then  
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Group:Rules"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم ازالة قوانين المجموعه","md",true)    
end
if text == "القوانين" then 
local Rules = redis:get(Jack.."Jack:Group:Rules" .. msg_chat_id)   
if Rules then     
return LuaTele.sendText(msg_chat_id,msg_id,Rules,"md",true)     
else      
return LuaTele.sendText(msg_chat_id,msg_id,"• لا توجد قوانين هنا","md",true)     
end    
end
if text == "ضع وصف" or text == "وضع وصف" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).Info == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه تغيير المعلومات ',"md",true)  
end
redis:setex(Jack.."Jack:Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل لي وصف المجموعه الان","md",true)  
end
if text == "مسح الوصف" or text == "حذف الوصف" then  
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).Info == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه تغيير المعلومات ',"md",true)  
end
LuaTele.setChatDescription(msg_chat_id, '') 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم ازالة قوانين المجموعه","md",true)    
end

if text and text:match("^ضع اسم (.*)") or text and text:match("^وضع اسم (.*)") then 
local NameChat = text:match("^ضع اسم (.*)") or text:match("^وضع اسم (.*)") 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).Info == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه تغيير المعلومات ',"md",true)  
end
LuaTele.setChatTitle(msg_chat_id,NameChat)
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تغيير اسم المجموعه الى : "..NameChat,"md",true)    
end

if text == ("ضع صوره") then  
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if GetInfoBot(msg).Info == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه تغيير المعلومات ',"md",true)  
end
redis:set(Jack.."Jack:Chat:Photo"..msg_chat_id..":"..msg.sender.user_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل الصوره لوضعها","md",true)    
end

if text == "مسح قائمه المنع" then   
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
local list = redis:smembers(Jack.."Jack:List:Filter"..msg_chat_id)  
if #list == 0 then  
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد كلمات ممنوعه هنا ","md",true)   
end  
for k,v in pairs(list) do  
v = v:gsub('photo:',"") 
v = v:gsub('sticker:',"") 
v = v:gsub('animation:',"") 
v = v:gsub('text:',"") 
redis:del(Jack.."Jack:Filter:Group:"..v..msg_chat_id)  
redis:srem(Jack.."Jack:List:Filter"..msg_chat_id,v)  
end  
return LuaTele.sendText(msg_chat_id,msg_id,"• تم مسح ("..#list..") كلمات ممنوعه ","md",true)   
end
if text == "قائمه المنع" then   
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
local list = redis:smembers(Jack.."Jack:List:Filter"..msg_chat_id)  
if #list == 0 then  
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد كلمات ممنوعه هنا ","md",true)   
end  
Filter = '\n• قائمه المنع \n ━━━━━━━━━━━━\n'
for k,v in pairs(list) do  
print(v)
if v:match('photo:(.*)') then
ver = 'صوره'
elseif v:match('animation:(.*)') then
ver = 'متحركه'
elseif v:match('sticker:(.*)') then
ver = 'ملصق'
elseif v:match('text:(.*)') then
ver = v:gsub('text:',"") 
end
v = v:gsub('photo:',"") 
v = v:gsub('sticker:',"") 
v = v:gsub('animation:',"") 
v = v:gsub('text:',"") 
local Text_Filter = redis:get(Jack.."Jack:Filter:Group:"..v..msg_chat_id)   
Filter = Filter..""..k.."- "..ver.." »  "..Text_Filter.." \n"    
end  
LuaTele.sendText(msg_chat_id,msg_id,Filter,"md",true)  
end  
if text == "منع" then       
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack..'Jack:FilterText'..msg_chat_id..':'..msg.sender.user_id,'true')
return LuaTele.sendText(msg_chat_id,msg_id,'\n• ارسل الان  ملصق ,متحركه ,صوره ,رساله  ',"md",true)  
end    
if text == "الغاء منع" then    
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack..'Jack:FilterText'..msg_chat_id..':'..msg.sender.user_id,'DelFilter')
return LuaTele.sendText(msg_chat_id,msg_id,'\n• ارسل الان  ملصق ,متحركه ,صوره ,رساله  ',"md",true)  
end

if text == "اضف امر عام" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:All:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id,"true") 
return LuaTele.sendText(msg_chat_id,msg_id,"• الان ارسل لي الامر القديم ...","md",true)
end
if text == "حذف امر عام" or text == "مسح امر عام" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:All:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id,"true") 
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل الان الامر الذي قمت بوضعه مكان الامر القديم","md",true)
end
if text == "حذف الاوامر المضافه العامه" or text == "مسح الاوامر المضافه العامه" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
local list = redis:smembers(Jack.."Jack:All:Command:List:Group")
for k,v in pairs(list) do
redis:del(Jack.."Jack:All:Get:Reides:Commands:Group"..v)
redis:del(Jack.."Jack:All:Command:List:Group")
end
return LuaTele.sendText(msg_chat_id,msg_id,"• تم مسح جميع الاوامر التي تم اضافتها في العام","md",true)
end
if text == "الاوامر المضافه العامه" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
local list = redis:smembers(Jack.."Jack:All:Command:List:Group")
Command = "• قائمه الاوامر المضافه العامه  \n━━━━━━━━━━━━\n"
for k,v in pairs(list) do
Commands = redis:get(Jack.."Jack:All:Get:Reides:Commands:Group"..v)
if Commands then 
Command = Command..""..k..": ("..v..") ↤︎ "..Commands.."\n"
else
Command = Command..""..k..": ("..v..") \n"
end
end
if #list == 0 then
Command = "• لا توجد اوامر اضافيه عامه"
end
return LuaTele.sendText(msg_chat_id,msg_id,Command,"md",true)
end


if text == "اضف امر" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id,"true") 
return LuaTele.sendText(msg_chat_id,msg_id,"• الان ارسل لي الامر القديم ...","md",true)
end
if text == "حذف امر" or text == "مسح امر" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id,"true") 
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل الان الامر الذي قمت بوضعه مكان الامر القديم","md",true)
end
if text == "حذف الاوامر المضافه" or text == "مسح الاوامر المضافه" then 
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
local list = redis:smembers(Jack.."Jack:Command:List:Group"..msg_chat_id)
for k,v in pairs(list) do
redis:del(Jack.."Jack:Get:Reides:Commands:Group"..msg_chat_id..":"..v)
redis:del(Jack.."Jack:Command:List:Group"..msg_chat_id)
end
return LuaTele.sendText(msg_chat_id,msg_id,"• تم مسح جميع الاوامر التي تم اضافتها","md",true)
end
if text == "الاوامر المضافه" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
local list = redis:smembers(Jack.."Jack:Command:List:Group"..msg_chat_id.."")
Command = "• قائمه الاوامر المضافه  \n━━━━━━━━━━━━\n"
for k,v in pairs(list) do
Commands = redis:get(Jack.."Jack:Get:Reides:Commands:Group"..msg_chat_id..":"..v)
if Commands then 
Command = Command..""..k..": ("..v..") ↤︎ "..Commands.."\n"
else
Command = Command..""..k..": ("..v..") \n"
end
end
if #list == 0 then
Command = "• لا توجد اوامر اضافيه"
end
return LuaTele.sendText(msg_chat_id,msg_id,Command,"md",true)
end

if text == "تثبيت" and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).PinMsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه تثبيت الرسائل ',"md",true)  
end
LuaTele.sendText(msg_chat_id,msg_id,"\n• تم تثبيت الرساله","md",true)
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local PinMsg = LuaTele.pinChatMessage(msg_chat_id,Message_Reply.id,true)
end
if text == 'الغاء التثبيت' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).PinMsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه تثبيت الرسائل ',"md",true)  
end
LuaTele.sendText(msg_chat_id,msg_id,"\n• تم الغاء تثبيت الرساله","md",true)
LuaTele.unpinChatMessage(msg_chat_id) 
end
if text == 'الغاء تثبيت الكل' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).PinMsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه تثبيت الرسائل ',"md",true)  
end
LuaTele.sendText(msg_chat_id,msg_id,"\n• تم الغاء تثبيت كل الرسائل","md",true)
LuaTele.unpinAllChatMessages(msg_chat_id)
end
if text == "الحمايه" then    
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تعطيل الرابط', data = msg.sender.user_id..'/'.. 'unmute_link'},{text = 'تفعيل الرابط', data = msg.sender.user_id..'/'.. 'mute_link'},
},
{
{text = 'تعطيل الترحيب', data = msg.sender.user_id..'/'.. 'unmute_welcome'},{text = 'تفعيل الترحيب', data = msg.sender.user_id..'/'.. 'mute_welcome'},
},
{
{text = 'اتعطيل الايدي', data = msg.sender.user_id..'/'.. 'unmute_Id'},{text = 'اتفعيل الايدي', data = msg.sender.user_id..'/'.. 'mute_Id'},
},
{
{text = 'تعطيل الايدي بالصوره', data = msg.sender.user_id..'/'.. 'unmute_IdPhoto'},{text = 'تفعيل الايدي بالصوره', data = msg.sender.user_id..'/'.. 'mute_IdPhoto'},
},
{
{text = 'تعطيل ردود المدير', data = msg.sender.user_id..'/'.. 'unmute_ryple'},{text = 'تفعيل ردود المدير', data = msg.sender.user_id..'/'.. 'mute_ryple'},
},
{
{text = 'تعطيل ردود المطور', data = msg.sender.user_id..'/'.. 'unmute_ryplesudo'},{text = 'تفعيل ردود المطور', data = msg.sender.user_id..'/'.. 'mute_ryplesudo'},
},
{
{text = 'تعطيل الرفع', data = msg.sender.user_id..'/'.. 'unmute_setadmib'},{text = 'تفعيل الرفع', data = msg.sender.user_id..'/'.. 'mute_setadmib'},
},
{
{text = 'تعطيل الطرد', data = msg.sender.user_id..'/'.. 'unmute_kickmembars'},{text = 'تفعيل الطرد', data = msg.sender.user_id..'/'.. 'mute_kickmembars'},
},
{
{text = 'تعطيل الالعاب', data = msg.sender.user_id..'/'.. 'unmute_games'},{text = 'تفعيل الالعاب', data = msg.sender.user_id..'/'.. 'mute_games'},
},
{
{text = 'تعطيل اطردني', data = msg.sender.user_id..'/'.. 'unmute_kickme'},{text = 'تفعيل اطردني', data = msg.sender.user_id..'/'.. 'mute_kickme'},
},
{
{text = '- اخفاء الامر ', data =msg.sender.user_id..'/'.. 'delAmr'}
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id, '• اوامر التفعيل والتعطيل ', "md", false, false, false, false, reply_markup)
end  
if text == 'اعدادات الحمايه' then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if redis:get(Jack.."Jack:Status:Link"..msg.chat_id) then
Statuslink = '〖  نعم 〗' else Statuslink = '〖  لا 〗'
end
if redis:get(Jack.."Jack:Status:Welcome"..msg.chat_id) then
StatusWelcome = '〖  نعم 〗' else StatusWelcome = '〖  لا 〗'
end
if redis:get(Jack.."lock_id"..msg.chat_id) then
StatusId = '〖  نعم 〗' else StatusId = '〖  لا 〗'
end
if redis:get(Jack.."Jack:Status:IdPhoto"..msg.chat_id) then
StatusIdPhoto = '〖  نعم 〗' else StatusIdPhoto = '〖  لا 〗'
end
if redis:get(Jack.."Jack:Status:Reply"..msg.chat_id) then
StatusReply = '〖  نعم 〗' else StatusReply = '〖  لا 〗'
end
if redis:get(Jack.."Jack:Status:ReplySudo"..msg.chat_id) then
StatusReplySudo = '〖  نعم 〗' else StatusReplySudo = '〖  لا 〗'
end
if redis:get(Jack.."Jack:Status:BanId"..msg.chat_id)  then
StatusBanId = '〖  نعم 〗' else StatusBanId = '〖  لا 〗'
end
if redis:get(Jack.."Jack:Status:SetId"..msg.chat_id) then
StatusSetId = '〖  نعم 〗' else StatusSetId = '〖  لا 〗'
end
if redis:get(Jack.."Jack:Status:Games"..msg.chat_id) then
StatusGames = '〖  نعم 〗' else StatusGames = '〖  لا 〗'
end
if redis:get(Jack.."Jack:Status:KickMe"..msg.chat_id) then
Statuskickme = '〖  نعم 〗' else Statuskickme = '〖  لا 〗'
end
if redis:get(Jack.."Jack:Status:AddMe"..msg.chat_id) then
StatusAddme = '〖  نعم 〗' else StatusAddme = '〖  لا 〗'
end
local protectionGroup = '\n• اعدادات حمايه المجموعه\n ━━━━━━━━━━━━\n'
..'\n• جلب الرابط ➤ '..Statuslink
..'\n• جلب الترحيب ➤ '..StatusWelcome
..'\n• الايدي ➤ '..StatusId
..'\n• الايدي بالصوره ➤ '..StatusIdPhoto
..'\n• ردود المدير ➤ '..StatusReply
..'\n• ردود المطور ➤ '..StatusReplySudo
..'\n• الرفع ➤ '..StatusSetId
..'\n• الحظر - الطرد ➤ '..StatusBanId
..'\n• الالعاب ➤ '..StatusGames
..'\n• امر اطردني ➤ '..Statuskickme..''
return LuaTele.sendText(msg_chat_id, msg_id,protectionGroup)
end
if text == "الاعدادات" then    
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
local Text = "\n• اعدادات المجموعه ".."\n• علامة ال (نعم) تعني مقفول".."\n🔓︙علامة ال (لا) تعني مفتوح"
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = GetSetieng(msg_chat_id).lock_links, data = '&'},{text = 'الروابط : ', data =msg.sender.user_id..'/'.. 'Status_link'},
},
{
{text = GetSetieng(msg_chat_id).lock_spam, data = '&'},{text = 'الكلايش : ', data =msg.sender.user_id..'/'.. 'Status_spam'},
},
{
{text = GetSetieng(msg_chat_id).lock_inlin, data = '&'},{text = 'الكيبورد : ', data =msg.sender.user_id..'/'.. 'Status_keypord'},
},
{
{text = GetSetieng(msg_chat_id).lock_vico, data = '&'},{text = 'الاغاني : ', data =msg.sender.user_id..'/'.. 'Status_voice'},
},
{
{text = GetSetieng(msg_chat_id).lock_gif, data = '&'},{text = 'المتحركه : ', data =msg.sender.user_id..'/'.. 'Status_gif'},
},
{
{text = GetSetieng(msg_chat_id).lock_file, data = '&'},{text = 'الملفات : ', data =msg.sender.user_id..'/'.. 'Status_files'},
},
{
{text = GetSetieng(msg_chat_id).lock_text, data = '&'},{text = 'الدردشه : ', data =msg.sender.user_id..'/'.. 'Status_text'},
},
{
{text = GetSetieng(msg_chat_id).lock_ved, data = '&'},{text = 'الفيديو : ', data =msg.sender.user_id..'/'.. 'Status_video'},
},
{
{text = GetSetieng(msg_chat_id).lock_photo, data = '&'},{text = 'الصور : ', data =msg.sender.user_id..'/'.. 'Status_photo'},
},
{
{text = GetSetieng(msg_chat_id).lock_user, data = '&'},{text = 'المعرفات : ', data =msg.sender.user_id..'/'.. 'Status_username'},
},
{
{text = GetSetieng(msg_chat_id).lock_hash, data = '&'},{text = 'التاك : ', data =msg.sender.user_id..'/'.. 'Status_tags'},
},
{
{text = GetSetieng(msg_chat_id).lock_bots, data = '&'},{text = 'البوتات : ', data =msg.sender.user_id..'/'.. 'Status_bots'},
},
{
{text = '- التالي ... ', data =msg.sender.user_id..'/'.. 'NextSeting'}
},
{
{text = '- اخفاء الامر ', data =msg.sender.user_id..'/'.. 'delAmr'}
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id, Text, "md", false, false, false, false, reply_markup)
end  


if text == 'المجموعه' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
local Get_Chat = LuaTele.getChat(msg_chat_id)
if Get_Chat.permissions.can_add_web_page_previews then
web = '〖  نعم 〗' else web = '〖  لا 〗'
end
if Get_Chat.permissions.can_change_info then
info = '〖  نعم 〗' else info = '〖  لا 〗'
end
if Get_Chat.permissions.can_invite_users then
invite = '〖  نعم 〗' else invite = '〖  لا 〗'
end
if Get_Chat.permissions.can_pin_messages then
pin = '〖  نعم 〗' else pin = '〖  لا 〗'
end
if Get_Chat.permissions.can_send_media_messages then
media = '〖  نعم 〗' else media = '〖  لا 〗'
end
if Get_Chat.permissions.can_send_messages then
messges = '〖  نعم 〗' else messges = '〖  لا 〗'
end
if Get_Chat.permissions.can_send_other_messages then
other = '〖  نعم 〗' else other = '〖  لا 〗'
end
if Get_Chat.permissions.can_send_polls then
polls = '〖  نعم 〗' else polls = '〖  لا 〗'
end
local permissions = '\n• صلاحيات المجموعه :\n━━━━━━━━━━━━'..'\n• ارسال الويب : '..web..'\n• تغيير معلومات المجموعه : '..info..'\n• اضافه مستخدمين : '..invite..'\n• تثبيت الرسائل : '..pin..'\n• ارسال الميديا : '..media..'\n• ارسال الرسائل : '..messges..'\n• اضافه البوتات : '..other..'\n• ارسال استفتاء : '..polls..'\n\n'
local TextChat = '\n• معلومات المجموعه :\n━━━━━━━━━━━━'..' \n• عدد الادمنيه : 〖  '..Info_Chats.administrator_count..' 〗\n• عدد المحظورين : 〖  '..Info_Chats.banned_count..' 〗\n• عدد الاعضاء : 〖  '..Info_Chats.member_count..' 〗\n• عدد المقيديين : 〖  '..Info_Chats.restricted_count..' 〗\n• اسم المجموعه : 〖  ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..') 〗'
return LuaTele.sendText(msg_chat_id,msg_id, TextChat..permissions,"md",true)
end
if text == 'صلاحيات المجموعه' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
if Get_Chat.permissions.can_add_web_page_previews then
web = '〖  نعم 〗' else web = '〖  لا 〗'
end
if Get_Chat.permissions.can_change_info then
info = '〖  نعم 〗' else info = '〖  لا 〗'
end
if Get_Chat.permissions.can_invite_users then
invite = '〖  نعم 〗' else invite = '〖  لا 〗'
end
if Get_Chat.permissions.can_pin_messages then
pin = '〖  نعم 〗' else pin = '〖  لا 〗'
end
if Get_Chat.permissions.can_send_media_messages then
media = '〖  نعم 〗' else media = '〖  لا 〗'
end
if Get_Chat.permissions.can_send_messages then
messges = '〖  نعم 〗' else messges = '〖  لا 〗'
end
if Get_Chat.permissions.can_send_other_messages then
other = '〖  نعم 〗' else other = '〖  لا 〗'
end
if Get_Chat.permissions.can_send_polls then
polls = '〖  نعم 〗' else polls = '〖  لا 〗'
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- ارسال الويب : '..web, data = msg.sender.user_id..'/web'}, 
},
{
{text = '- تغيير معلومات المجموعه : '..info, data =msg.sender.user_id..  '/info'}, 
},
{
{text = '- اضافه مستخدمين : '..invite, data =msg.sender.user_id..  '/invite'}, 
},
{
{text = '- تثبيت الرسائل : '..pin, data =msg.sender.user_id..  '/pin'}, 
},
{
{text = '- ارسال الميديا : '..media, data =msg.sender.user_id..  '/media'}, 
},
{
{text = '- ارسال الرسائل : .'..messges, data =msg.sender.user_id..  '/messges'}, 
},
{
{text = '- اضافه البوتات : '..other, data =msg.sender.user_id..  '/other'}, 
},
{
{text = '- ارسال استفتاء : '..polls, data =msg.sender.user_id.. '/polls'}, 
},
{
{text = '- اخفاء الامر ', data =msg.sender.user_id..'/'.. 'delAmr'}
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id, "•  الصلاحيات - ", "md", false, false, false, false, reply_markup)
end
if text == 'تنزيل الكل' and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على البوت ","md",true)  
end
if redis:sismember(Jack.."Jack:Developers:Groups",Message_Reply.sender.user_id) then
dev = "المطور " else dev = "" end
if redis:sismember(Jack..":MONSHA_Groupp:"..msg_chat_id, Message_Reply.sender.user_id) then
crr = "منشئ اساسي " else crr = "" end
if redis:sismember(Jack..'Jack:Originators:Group'..msg_chat_id, Message_Reply.sender.user_id) then
cr = "منشئ " else cr = "" end
if redis:sismember(Jack..'Jack:Managers:Group'..msg_chat_id, Message_Reply.sender.user_id) then
own = "مدير " else own = "" end
if redis:sismember(Jack..'Jack:Addictive:Group'..msg_chat_id, Message_Reply.sender.user_id) then
mod = "ادمن " else mod = "" end
if redis:sismember(Jack..'Jack:Distinguished:Group'..msg_chat_id, Message_Reply.sender.user_id) then
vip = "مميز " else vip = ""
end
if The_ControllerAll(Message_Reply.sender.user_id) == true then
Rink = 1
elseif redis:sismember(Jack.."Jack:Developers:Groups",Message_Reply.sender.user_id)  then
Rink = 2
elseif redis:sismember(Jack..":MONSHA_Groupp:"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 3
elseif redis:sismember(Jack.."Jack:Originators:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 4
elseif redis:sismember(Jack.."Jack:Managers:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 5
elseif redis:sismember(Jack.."Jack:Addictive:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 6
elseif redis:sismember(Jack.."Jack:Distinguished:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 7
else
Rink = 8
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• ليس لديه اي رتبه هنا ","md",true)  
end
if msg.ControllerBot then
if Rink == 1 or Rink < 1 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك ","md",true)  
end
redis:srem(Jack.."Jack:Developers:Groups",Message_Reply.sender.user_id)
redis:srem(Jack..":MONSHA_Groupp:"..msg_chat_id, Message_Reply.sender.user_id)
redis:srem(Jack.."Jack:Originators:Group"..msg_chat_id, Message_Reply.sender.user_id)
redis:srem(Jack.."Jack:Managers:Group"..msg_chat_id, Message_Reply.sender.user_id)
redis:srem(Jack.."Jack:Addictive:Group"..msg_chat_id, Message_Reply.sender.user_id)
redis:srem(Jack.."Jack:Distinguished:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Developers then
if Rink == 2 or Rink < 2 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك ","md",true)  
end
redis:srem(Jack..":MONSHA_Groupp:"..msg_chat_id, Message_Reply.sender.user_id)
redis:srem(Jack.."Jack:Originators:Group"..msg_chat_id, Message_Reply.sender.user_id)
redis:srem(Jack.."Jack:Managers:Group"..msg_chat_id, Message_Reply.sender.user_id)
redis:srem(Jack.."Jack:Addictive:Group"..msg_chat_id, Message_Reply.sender.user_id)
redis:srem(Jack.."Jack:Distinguished:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.TheBasics then
if Rink == 3 or Rink < 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك ","md",true)  
end
redis:srem(Jack.."Jack:Originators:Group"..msg_chat_id, Message_Reply.sender.user_id)
redis:srem(Jack.."Jack:Managers:Group"..msg_chat_id, Message_Reply.sender.user_id)
redis:srem(Jack.."Jack:Addictive:Group"..msg_chat_id, Message_Reply.sender.user_id)
redis:srem(Jack.."Jack:Distinguished:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Originators then
if Rink == 4 or Rink < 4 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك ","md",true)  
end
redis:srem(Jack.."Jack:Managers:Group"..msg_chat_id, Message_Reply.sender.user_id)
redis:srem(Jack.."Jack:Addictive:Group"..msg_chat_id, Message_Reply.sender.user_id)
redis:srem(Jack.."Jack:Distinguished:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Managers then
if Rink == 5 or Rink < 5 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك ","md",true)  
end
redis:srem(Jack.."Jack:Addictive:Group"..msg_chat_id, Message_Reply.sender.user_id)
redis:srem(Jack.."Jack:Distinguished:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Addictive then
if Rink == 6 or Rink < 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك ","md",true)  
end
redis:srem(Jack.."Jack:Distinguished:Group"..msg_chat_id, Message_Reply.sender.user_id)
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n• تم تنزيل الشخص من الرتب التاليه  "..dev..""..crr..""..cr..""..own..""..mod..""..vip.." ","md",true)  
end

if text and text:match('^تنزيل الكل @(%S+)$') then
local UserName = text:match('^تنزيل الكل @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف قناة او قروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف البوت ","md",true)  
end
if redis:sismember(Jack.."Jack:Developers:Groups",UserId_Info.id) then
dev = "المطور " else dev = "" end
if redis:sismember(Jack..":MONSHA_Groupp:"..msg_chat_id, UserId_Info.id) then
crr = "منشئ اساسي " else crr = "" end
if redis:sismember(Jack..'Jack:Originators:Group'..msg_chat_id, UserId_Info.id) then
cr = "منشئ " else cr = "" end
if redis:sismember(Jack..'Jack:Managers:Group'..msg_chat_id, UserId_Info.id) then
own = "مدير " else own = "" end
if redis:sismember(Jack..'Jack:Addictive:Group'..msg_chat_id, UserId_Info.id) then
mod = "ادمن " else mod = "" end
if redis:sismember(Jack..'Jack:Distinguished:Group'..msg_chat_id, UserId_Info.id) then
vip = "مميز " else vip = ""
end
if The_ControllerAll(UserId_Info.id) == true then
Rink = 1
elseif redis:sismember(Jack.."Jack:Developers:Groups",UserId_Info.id)  then
Rink = 2
elseif redis:sismember(Jack..":MONSHA_Groupp:"..msg_chat_id, UserId_Info.id) then
Rink = 3
elseif redis:sismember(Jack.."Jack:Originators:Group"..msg_chat_id, UserId_Info.id) then
Rink = 4
elseif redis:sismember(Jack.."Jack:Managers:Group"..msg_chat_id, UserId_Info.id) then
Rink = 5
elseif redis:sismember(Jack.."Jack:Addictive:Group"..msg_chat_id, UserId_Info.id) then
Rink = 6
elseif redis:sismember(Jack.."Jack:Distinguished:Group"..msg_chat_id, UserId_Info.id) then
Rink = 7
else
Rink = 8
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• ليس لديه اي رتبه هنا ","md",true)  
end
if msg.ControllerBot then
if Rink == 1 or Rink < 1 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك ","md",true)  
end
redis:srem(Jack.."Jack:Developers:Groups",UserId_Info.id)
redis:srem(Jack..":MONSHA_Groupp:"..msg_chat_id, UserId_Info.id)
redis:srem(Jack.."Jack:Originators:Group"..msg_chat_id, UserId_Info.id)
redis:srem(Jack.."Jack:Managers:Group"..msg_chat_id, UserId_Info.id)
redis:srem(Jack.."Jack:Addictive:Group"..msg_chat_id, UserId_Info.id)
redis:srem(Jack.."Jack:Distinguished:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Developers then
if Rink == 2 or Rink < 2 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك ","md",true)  
end
redis:srem(Jack..":MONSHA_Groupp:"..msg_chat_id, UserId_Info.id)
redis:srem(Jack.."Jack:Originators:Group"..msg_chat_id, UserId_Info.id)
redis:srem(Jack.."Jack:Managers:Group"..msg_chat_id, UserId_Info.id)
redis:srem(Jack.."Jack:Addictive:Group"..msg_chat_id, UserId_Info.id)
redis:srem(Jack.."Jack:Distinguished:Group"..msg_chat_id, UserId_Info.id)
elseif msg.TheBasics then
if Rink == 3 or Rink < 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك ","md",true)  
end
redis:srem(Jack.."Jack:Originators:Group"..msg_chat_id, UserId_Info.id)
redis:srem(Jack.."Jack:Managers:Group"..msg_chat_id, UserId_Info.id)
redis:srem(Jack.."Jack:Addictive:Group"..msg_chat_id, UserId_Info.id)
redis:srem(Jack.."Jack:Distinguished:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Originators then
if Rink == 4 or Rink < 4 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك ","md",true)  
end
redis:srem(Jack.."Jack:Managers:Group"..msg_chat_id, UserId_Info.id)
redis:srem(Jack.."Jack:Addictive:Group"..msg_chat_id, UserId_Info.id)
redis:srem(Jack.."Jack:Distinguished:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Managers then
if Rink == 5 or Rink < 5 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك ","md",true)  
end
redis:srem(Jack.."Jack:Addictive:Group"..msg_chat_id, UserId_Info.id)
redis:srem(Jack.."Jack:Distinguished:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Addictive then
if Rink == 6 or Rink < 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك ","md",true)  
end
redis:srem(Jack.."Jack:Distinguished:Group"..msg_chat_id, UserId_Info.id)
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n• تم تنزيل الشخص من الرتب التاليه  "..dev..""..crr..""..cr..""..own..""..mod..""..vip.." ","md",true)  
end

if text and text:match('تغيير (.*)') and msg.reply_to_message_id ~= 0 then
local CustomTitle = text:match('تغيير (.*)')
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(4)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه اضافة مشرفين ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على البوت ","md",true)  
end
local SetCustomTitle = https.request("https://api.telegram.org/bot"..Token.."/setChatAdministratorCustomTitle?chat_id="..msg_chat_id.."&user_id="..Message_Reply.sender.user_id.."&custom_title="..CustomTitle)
local SetCustomTitle_ = JSON.decode(SetCustomTitle)
if SetCustomTitle_.result == true then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم وضع له لقب : "..CustomTitle).Reply,"md",true)  
else
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً هناك خطا تاكد من البوت ومن الشخص","md",true)  
end 
end
if text and text:match('^تغيير @(%S+) (.*)$') then
local UserName = {text:match('^تغيير @(%S+) (.*)$')}
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(4)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له .","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه اضافة مشرفين ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName[1])
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف قناة او قروب ","md",true)  
end
if UserName and UserName[1]:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف البوت ","md",true)  
end
local SetCustomTitle = https.request("https://api.telegram.org/bot"..Token.."/setChatAdministratorCustomTitle?chat_id="..msg_chat_id.."&user_id="..UserId_Info.id.."&custom_title="..UserName[2])
local SetCustomTitle_ = JSON.decode(SetCustomTitle)
if SetCustomTitle_.result == true then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم وضع له لقب : "..UserName[2]).Reply,"md",true)  
else
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً هناك خطا تاكد من البوت ومن الشخص","md",true)  
end 
end 
if text == ('رفع مشرف') and msg.reply_to_message_id ~= 0 then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(4)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه اضافة مشرفين ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'administrator',{1 ,1, 0, 0, 0, 0, 0 , 0, 0, 0, 0, 0, ''})
if SetAdmin.code == 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لا يمكنني رفعه ليس لدي صلاحيات ","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- تعديل الصلاحيات ', data = msg.sender.user_id..'/groupNumseteng//'..Message_Reply.sender.user_id}, 
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id, "•  صلاحيات المستخدم - ", "md", false, false, false, false, reply_markup)
end
if text and text:match('^رفع مشرف @(%S+)$') then
local UserName = text:match('^رفع مشرف @(%S+)$')
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(4)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه اضافة مشرفين ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف قناة او قروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'administrator',{1 ,1, 0, 0, 0, 0, 0 , 0, 0, 0, 0, 0, ''})
var(SetAdmin)
if SetAdmin.code == 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لا يمكنني رفعه ليس لدي صلاحيات ","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- تعديل الصلاحيات ', data = msg.sender.user_id..'/groupNumseteng//'..UserId_Info.id}, 
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id, "•  صلاحيات المستخدم - ", "md", false, false, false, false, reply_markup)
end 
if text == ('تنزيل مشرف') and msg.reply_to_message_id ~= 0 then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(4)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه اضافة مشرفين ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'administrator',{0 ,0, 0, 0, 0, 0, 0 ,0, 0})
if SetAdmin.code == 400 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لست انا من قام برفعه ","md",true)  
end
if SetAdmin.code == 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لا يمكنني تنزيله ليس لدي صلاحيات ","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم تنزيله من المشرفين ").Reply,"md",true)  
end
if text and text:match('^تنزيل مشرف @(%S+)$') then
local UserName = text:match('^تنزيل مشرف @(%S+)$')
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(4)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه اضافة مشرفين ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف قناة او قروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'administrator',{0 ,0, 0, 0, 0, 0, 0 ,0, 0})
if SetAdmin.code == 400 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لست انا من قام برفعه ","md",true)  
end
if SetAdmin.code == 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لا يمكنني تنزيله ليس لدي صلاحيات ","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"• تم تنزيله من المشرفين ").Reply,"md",true)  
end 
if text == 'مسح رسائلي' then
redis:del(Jack..'msgs:'..msg.chat_id..':'..msg.sender.user_id)
LuaTele.sendText(msg_chat_id,msg_id,'• تم مسح جميع رسائلك ',"md",true)  
elseif text == 'مسح سحكاتي' or text == 'مسح تعديلاتي' then
redis:del(Jack..'Jack:Num:Message:Edit'..msg.chat_id..':'..msg.sender.user_id)
LuaTele.sendText(msg_chat_id,msg_id,'• تم مسح جميع تعديلاتك ',"md",true)  
elseif text == 'مسح جهاتي' then
redis:del(Jack..'Jack:Num:Add:Memp'..msg.chat_id..':'..msg.sender.user_id)
LuaTele.sendText(msg_chat_id,msg_id,'• تم مسح جميع جهاتك المضافه ',"md",true)  
elseif text == 'رسائلي' then
LuaTele.sendText(msg_chat_id,msg_id,'• عدد رسائلك هنا ~ '..(redis:get(Jack..'msgs:'..msg.chat_id..':'..msg.sender.user_id) or 1)..'',"md",true)  
elseif text == 'سحكاتي' or text == 'تعديلاتي' then
LuaTele.sendText(msg_chat_id,msg_id,'• عدد التعديلات هنا ~ '..(redis:get(Jack..'Jack:Num:Message:Edit'..msg.chat_id..msg.sender.user_id) or 0)..'',"md",true)  
elseif text == 'جهاتي' then
LuaTele.sendText(msg_chat_id,msg_id,'• عدد جهاتك المضافه هنا ~ '..(redis:get(Jack.."Jack:Num:Add:Memp"..msg.chat_id..":"..msg.sender.user_id) or 0)..'',"md",true)  
elseif text == 'مسح' and msg.reply_to_message_id ~= 0 and msg.Addictive then
if GetInfoBot(msg).Delmsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه حذف الرسائل ',"md",true)  
end
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.reply_to_message_id})
LuaTele.deleteMessages(msg.chat_id,{[1]= msg_id})
end
if text == 'تعين الايدي عام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:setex(Jack.."Jack:redis:Id:Groups"..msg.chat_id..""..msg.sender.user_id,240,true)  
return LuaTele.sendText(msg_chat_id,msg_id,[[
• ارسل الان النص
• يمكنك اضافه :
`#اليوزر` » اسم المستخدم
`#الرسائل` » عدد الرسائل
`#الصور` » عدد الصور
`#الايدي` » ايدي المستخدم
`#التفاعل` » نسبة التفاعل
`#الرتبه` » رتبة المستخدم 
`#التعديل` » عدد السحكات
`#النقاط` » عدد المجوهرات
`#الجهات` » عدد الجهات
`#التعليقات` » تعليق الصوره
]],"md",true)    
end 
if text == 'حذف الايدي عام' or text == 'مسح الايدي عام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Set:Id:Groups")
return LuaTele.sendText(msg_chat_id,msg_id, '• تم ازالة كليشة الايدي العامه',"md",true)  
end

if text == 'تعين الايدي' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:setex(Jack.."Jack:redis:Id:Group"..msg.chat_id..""..msg.sender.user_id,240,true)  
return LuaTele.sendText(msg_chat_id,msg_id,[[
• ارسل الان النص
• يمكنك اضافه :
`#اليوزر` » اسم المستخدم
`#الرسائل` » عدد الرسائل
`#الصور` » عدد الصور
`#الايدي` » ايدي المستخدم
`#التفاعل` » نسبة التفاعل
`#الرتبه` » رتبة المستخدم 
`#التعديل` » عدد السحكات
`#النقاط` » عدد المجوهرات
`#الجهات` » عدد الجهات
`#التعليقات` » تعليق الصوره
]],"md",true)    
end 
if text == 'حذف الايدي' or text == 'مسح الايدي' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Set:Id:Group"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id, '• تم ازالة كليشة الايدي ',"md",true)  
end

if text and text:match("^مسح (.*)$") and msg.reply_to_message_id == 0 then
local TextMsg = text:match("^مسح (.*)$")
if TextMsg == 'المطورين الثانوين' or TextMsg == 'المطورين الثانويين' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack.."Jack:DevelopersQ:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مطورين ثانوين حاليا , ","md",true)  
end
redis:del(Jack.."Jack:DevelopersQ:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم مسح "..#Info_Members.." من المطورين الثانويين","md",true)
end
if TextMsg == 'المطورين' then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(2)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack.."Jack:Developers:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مطورين حاليا , ","md",true)  
end
redis:del(Jack.."Jack:Developers:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم مسح "..#Info_Members.." من المطورين ","md",true)
end
if TextMsg == 'المنشئين الاساسيين' then
if not msg.TheBasicsm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(44)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack..":MONSHA_Groupp:"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد منشئين اساسيين حاليا , ","md",true)  
end
redis:del(Jack..":MONSHA_Groupp:"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم مسح "..#Info_Members.." من المنشؤين الاساسيين ","md",true)
end
if TextMsg == 'المالكين' then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(3)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack..":MONSHA_Groupp:"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مالكين حاليا , ","md",true)  
end
redis:del(Jack..":MONSHA_Groupp:"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم مسح "..#Info_Members.." من المالكين ","md",true)
end
if TextMsg == 'المنشئين' then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(4)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack.."Jack:Originators:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد منشئين حاليا , ","md",true)  
end
redis:del(Jack.."Jack:Originators:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم مسح "..#Info_Members.." من المنشئين ","md",true)
end
if TextMsg == 'المدراء' then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(5)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack.."Jack:Managers:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مدراء حاليا , ","md",true)  
end
redis:del(Jack.."Jack:Managers:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم مسح "..#Info_Members.." من المدراء ","md",true)
end
if TextMsg == 'الادمنيه' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack.."Jack:Addictive:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد ادمنيه حاليا , ","md",true)  
end
redis:del(Jack.."Jack:Addictive:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم مسح "..#Info_Members.." من الادمنيه ","md",true)
end
if TextMsg == 'المميزين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack.."Jack:Distinguished:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مميزين حاليا , ","md",true)  
end
redis:del(Jack.."Jack:Distinguished:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم مسح "..#Info_Members.." من المميزين ","md",true)
end
if TextMsg == 'المحظورين عام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack.."Jack:BanAll:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد محظورين عام حاليا , ","md",true)  
end
redis:del(Jack.."Jack:BanAll:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم مسح "..#Info_Members.." من المحظورين عام ","md",true)
end
if TextMsg == 'المكتومين عام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack.."Jack:BanAll:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مكتومين عام حاليا , ","md",true)  
end
redis:del(Jack.."Jack:ktmAll:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم مسح "..#Info_Members.." من المكتومين عام ","md",true)
end
if TextMsg == 'المحظورين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack.."Jack:BanGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد محظورين حاليا , ","md",true)  
end
redis:del(Jack.."Jack:BanGroup:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم مسح "..#Info_Members.." من المحظورين ","md",true)
end
if TextMsg == 'المكتومين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack.."Jack:SilentGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مكتومين حاليا , ","md",true)  
end
redis:del(Jack.."Jack:SilentGroup:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم مسح "..#Info_Members.." من المكتومين ","md",true)
end
if TextMsg == 'المقيدين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Recent", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.is_member == true and Info_Members.members[k].status.luatele == "chatMemberStatusRestricted" then
LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'restricted',{1,1,1,1,1,1,1,1})
x = x + 1
end
end
return LuaTele.sendText(msg_chat_id,msg_id,"• تم مسح "..x.." من المقيديين ","md",true)
end
if TextMsg == 'البوتات' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Bots", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
for k, v in pairs(List_Members) do
local Ban_Bots = LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'banned',0)
if Ban_Bots.luatele == "ok" then
x = x + 1
end
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عدد البوتات الموجوده : "..#List_Members.."\n• تم طرد ( "..x.." ) بوت من المجموعه ","md",true)  
end
if TextMsg == 'المطرودين' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Banned", "*", 0, 200)
x = 0
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
UNBan_Bots = LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
if UNBan_Bots.luatele == "ok" then
x = x + 1
end
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عدد المطرودين في الموجوده : "..#List_Members.."\n• تم الغاء الحظر عن ( "..x.." ) من الاشخاص","md",true)  
end
if TextMsg == 'المحذوفين' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• البوت ليس لديه صلاحيه حظر المستخدمين ',"md",true)  
end
local Info_Members = LuaTele.searchChatMembers(msg_chat_id, "*", 200)
local List_Members = Info_Members.members
x = 0
for k, v in pairs(List_Members) do
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.type.luatele == "userTypeDeleted" then
local userTypeDeleted = LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'banned',0)
if userTypeDeleted.luatele == "ok" then
x = x + 1
end
end
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n• تم طرد ( "..x.." ) حساب محذوف ","md",true)  
end
end


if text == ("مسح ردود المدير") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
local list = redis:smembers(Jack.."Jack:List:Manager"..msg_chat_id.."")
for k,v in pairs(list) do
redis:del(Jack.."Jack:Add:Rd:Manager:Gif"..v..msg_chat_id)   
redis:del(Jack.."Jack:Add:Rd:Manager:Vico"..v..msg_chat_id)   
redis:del(Jack.."Jack:Add:Rd:Manager:Stekrs"..v..msg_chat_id)     
redis:del(Jack.."Jack:Add:Rd:Manager:Text"..v..msg_chat_id)   
redis:del(Jack.."Jack:Add:Rd:Manager:Photo"..v..msg_chat_id)
redis:del(Jack.."Jack:Add:Rd:Manager:Video"..v..msg_chat_id)
redis:del(Jack.."Jack:Add:Rd:Manager:File"..v..msg_chat_id)
redis:del(Jack.."Jack:Add:Rd:Manager:video_note"..v..msg_chat_id)
redis:del(Jack.."Jack:Add:Rd:Manager:Audio"..v..msg_chat_id)
redis:del(Jack.."Jack:List:Manager"..msg_chat_id)
end
return LuaTele.sendText(msg_chat_id,msg_id,"• تم مسح قائمه ردود المدير","md",true)  
end
if text == ("ردود المدير") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
local list = redis:smembers(Jack.."Jack:List:Manager"..msg_chat_id.."")
text = "• قائمه ردود المدير \n━━━━━━━━━━━━\n"
for k,v in pairs(list) do
if redis:get(Jack.."Jack:Add:Rd:Manager:Gif"..v..msg_chat_id) then
db = "متحركه 🎭"
elseif redis:get(Jack.."Jack:Add:Rd:Manager:Vico"..v..msg_chat_id) then
db = "بصمه 📢"
elseif redis:get(Jack.."Jack:Add:Rd:Manager:Stekrs"..v..msg_chat_id) then
db = "ملصق 🃏"
elseif redis:get(Jack.."Jack:Add:Rd:Manager:Text"..v..msg_chat_id) then
db = "رساله ✉"
elseif redis:get(Jack.."Jack:Add:Rd:Manager:Photo"..v..msg_chat_id) then
db = "صوره 🎇"
elseif redis:get(Jack.."Jack:Add:Rd:Manager:Video"..v..msg_chat_id) then
db = "فيديو 📹"
elseif redis:get(Jack.."Jack:Add:Rd:Manager:File"..v..msg_chat_id) then
db = "ملف"
elseif redis:get(Jack.."Jack:Add:Rd:Manager:Audio"..v..msg_chat_id) then
db = "اغنيه 🎵"
elseif redis:get(Jack.."Jack:Add:Rd:Manager:video_note"..v..msg_chat_id) then
db = "بصمه فيديو 🎥"
end
text = text..""..k.." » "..v.." » "..db.."\n"
end
if #list == 0 then
text = "• عذرا لا يوجد ردود للمدير في المجموعه"
end
return LuaTele.sendText(msg_chat_id,msg_id,"["..text.."]","md",true)  
end
if text == "اضف رد" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل الان الكلمه لاضافتها في ردود المدير ","md",true)  
end
if text == "حذف رد" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id,"true2")
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل الان الكلمه لحذفها من ردود المدير","md",true)  
end
if text == ("مسح ردود المطور") then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
local list = redis:smembers(Jack.."Jack:List:Rd:Sudo")
for k,v in pairs(list) do
redis:del(Jack.."Jack:Add:Rd:Sudo:Gif"..v)   
redis:del(Jack.."Jack:Add:Rd:Sudo:vico"..v)   
redis:del(Jack.."Jack:Add:Rd:Sudo:stekr"..v)     
redis:del(Jack.."Jack:Add:Rd:Sudo:Text"..v)   
redis:del(Jack.."Jack:Add:Rd:Sudo:Photo"..v)
redis:del(Jack.."Jack:Add:Rd:Sudo:Video"..v)
redis:del(Jack.."Jack:Add:Rd:Sudo:File"..v)
redis:del(Jack.."Jack:Add:Rd:Sudo:Audio"..v)
redis:del(Jack.."Jack:Add:Rd:Sudo:video_note"..v)
redis:del(Jack.."Jack:List:Rd:Sudo")
end
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حذف ردود المطور","md",true)  
end
if text == ("ردود المطور") then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
local list = redis:smembers(Jack.."Jack:List:Rd:Sudo")
text = "\n📝︙قائمة ردود المطور \n━━━━━━━━━━━━\n"
for k,v in pairs(list) do
if redis:get(Jack.."Jack:Add:Rd:Sudo:Gif"..v) then
db = "متحركه 🎭"
elseif redis:get(Jack.."Jack:Add:Rd:Sudo:vico"..v) then
db = "بصمه 📢"
elseif redis:get(Jack.."Jack:Add:Rd:Sudo:stekr"..v) then
db = "ملصق 🃏"
elseif redis:get(Jack.."Jack:Add:Rd:Sudo:Text"..v) then
db = "رساله ✉"
elseif redis:get(Jack.."Jack:Add:Rd:Sudo:Photo"..v) then
db = "صوره 🎇"
elseif redis:get(Jack.."Jack:Add:Rd:Sudo:Video"..v) then
db = "فيديو 📹"
elseif redis:get(Jack.."Jack:Add:Rd:Sudo:File"..v) then
db = "ملف"
elseif redis:get(Jack.."Jack:Add:Rd:Sudo:Audio"..v) then
db = "اغنيه 🎵"
elseif redis:get(Jack.."Jack:Add:Rd:Sudo:video_note"..v) then
db = "بصمه فيديو 🎥"
end
text = text..""..k.." » "..v.." » "..db.."\n"
end
if #list == 0 then
text = "• لا توجد ردود للمطور"
end
return LuaTele.sendText(msg_chat_id,msg_id,"["..text.."]","md",true)  
end
if text == "اضف رد للكل" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Set:Rd"..msg.sender.user_id..":"..msg_chat_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل الان الكلمه لاضافتها في ردود المطور ","md",true)  
end
if text == "حذف رد للكل" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Set:On"..msg.sender.user_id..":"..msg_chat_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل الان الكلمه لحذفها من ردود المطور","md",true)  
end
if text=="اذاعه خاص" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(3)..' 〗 فقط . ',"md",true)  
end
if not msg.ControllerBot and not redis:set(Jack.."Jack:SendBcBot") then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• امر المغادره معطل من قبل الاساسي ',"md",true)  
end
redis:setex(Jack.."Jack:Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف • ملصق • متحركه • صوره
 • فيديو • بصمه الفيديو • بصمه • صوت • رساله ❩
━━━━━━━━━━━━
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=="اذاعه" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(3)..' 〗 فقط . ',"md",true)  
end
if not msg.ControllerBot and not redis:set(Jack.."Jack:SendBcBot") then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• امر المغادره معطل من قبل الاساسي ',"md",true)  
end
redis:setex(Jack.."Jack:Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف • ملصق • متحركه • صوره
 • فيديو • بصمه الفيديو • بصمه • صوت • رساله ❩
━━━━━━━━━━━━
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=="اذاعه بالتثبيت" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(3)..' 〗 فقط . ',"md",true)  
end
if not msg.ControllerBot and not redis:set(Jack.."Jack:SendBcBot") then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• امر المغادره معطل من قبل الاساسي ',"md",true)  
end
redis:setex(Jack.."Jack:Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف • ملصق • متحركه • صوره
 • فيديو • بصمه الفيديو • بصمه • صوت • رساله ❩
━━━━━━━━━━━━
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=="اذاعه بالتوجيه" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(3)..' 〗 فقط . ',"md",true)  
end
if not msg.ControllerBot and not redis:set(Jack.."Jack:SendBcBot") then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• امر المغادره معطل من قبل الاساسي ',"md",true)  
end
redis:setex(Jack.."Jack:Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,"• ارسل لي التوجيه الان\n• ليتم نشره في المجموعات","md",true)  
return false
end

if text=="اذاعه خاص بالتوجيه" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(3)..' 〗 فقط . ',"md",true)  
end
if not msg.ControllerBot and not redis:set(Jack.."Jack:SendBcBot") then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• امر المغادره معطل من قبل الاساسي ',"md",true)  
end
redis:setex(Jack.."Jack:Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,"• ارسل لي التوجيه الان\n• ليتم نشره الى المشتركين","md",true)  
return false
end
if text == 'كشف القيود' and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,Message_Reply.sender.user_id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
else
Restricted = 'غير مقيد'
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).BanAll == true then
BanAll = 'محظور عام'
else
BanAll = 'غير محظور عام'
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).BanGroup == true then
BanGroup = 'محظور'
else
BanGroup = 'غير محظور'
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).SilentGroup == true then
SilentGroup = 'مكتوم'
else
SilentGroup = 'غير مكتوم'
end
LuaTele.sendText(msg_chat_id,msg_id,"\n• معلومات الكشف \n━━━━━━━━━━━━"..'\n• الحظر العام : '..BanAll..'\n• الحظر : '..BanGroup..'\n• الكتم : '..SilentGroup..'\n• التقييد : '..Restricted..'',"md",true)  
end
if text and text:match('^كشف القيود @(%S+)$') then
local UserName = text:match('^كشف القيود @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف قناة او قروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف البوت ","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,UserId_Info.id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
else
Restricted = 'غير مقيد'
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanAll == true then
BanAll = 'محظور عام'
else
BanAll = 'غير محظور عام'
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanGroup == true then
BanGroup = 'محظور'
else
BanGroup = 'غير محظور'
end
if Statusrestricted(msg_chat_id,UserId_Info.id).SilentGroup == true then
SilentGroup = 'مكتوم'
else
SilentGroup = 'غير مكتوم'
end
LuaTele.sendText(msg_chat_id,msg_id,"\n• معلومات الكشف \n━━━━━━━━━━━━"..'\n• الحظر العام : '..BanAll..'\n• الحظر : '..BanGroup..'\n• الكتم : '..SilentGroup..'\n• التقييد : '..Restricted..'',"md",true)  
end
if text == 'رفع القيود' and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,Message_Reply.sender.user_id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1})
else
Restricted = ''
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).BanAll == true and msg.ControllerBot then
BanAll = 'محظور عام ,'
redis:srem(Jack.."Jack:BanAll:Groups",Message_Reply.sender.user_id) 
else
BanAll = ''
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).BanGroup == true then
BanGroup = 'محظور ,'
redis:srem(Jack.."Jack:BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
else
BanGroup = ''
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).SilentGroup == true then
SilentGroup = 'مكتوم ,'
redis:srem(Jack.."Jack:SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
else
SilentGroup = ''
end
LuaTele.sendText(msg_chat_id,msg_id,"\n• تم رفع القيود عنه : "..BanAll..BanGroup..SilentGroup..Restricted..'',"md",true)  
end
if text and text:match('^رفع القيود @(%S+)$') then
local UserName = text:match('^رفع القيود @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له ","md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف قناة او قروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام معرف البوت ","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,UserId_Info.id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1})
else
Restricted = ''
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanAll == true and msg.ControllerBot then
BanAll = 'محظور عام ,'
redis:srem(Jack.."Jack:BanAll:Groups",UserId_Info.id) 
else
BanAll = ''
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanGroup == true then
BanGroup = 'محظور ,'
redis:srem(Jack.."Jack:BanGroup:Group"..msg_chat_id,UserId_Info.id) 
else
BanGroup = ''
end
if Statusrestricted(msg_chat_id,UserId_Info.id).SilentGroup == true then
SilentGroup = 'مكتوم ,'
redis:srem(Jack.."Jack:SilentGroup:Group"..msg_chat_id,UserId_Info.id) 
else
SilentGroup = ''
end
LuaTele.sendText(msg_chat_id,msg_id,"\n• تم رفع القيود عنه : "..BanAll..BanGroup..SilentGroup..Restricted..'',"md",true)  
end

if text == 'وضع كليشه السورس' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack..'jsors'..msg_chat_id..':'..msg.sender.user_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,'•  ارسل لي الكليشه الان')
end
if text == 'وضع كليشه المطور' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack..'Jack:GetTexting:DevJack'..msg_chat_id..':'..msg.sender.user_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,'•  ارسل لي الكليشه الان')
end
if text == 'مسح كليشة المطور' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack..'Jack:Texting:DevJack')
return LuaTele.sendText(msg_chat_id,msg_id,'•  تم حذف كليشه المطور')
end
if text == 'المطور' or text == 'مطور' then
local TextingDevJack = redis:get(Jack..'Jack:Texting:DevJack')
if TextingDevJack then 
return LuaTele.sendText(msg_chat_id,msg_id,TextingDevJack,"md",true)  
else
local UserInfo = LuaTele.getUser(Sudo_Id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• مطور البوت : ['..UserInfo.first_name..'](tg://user?id='..UserInfo.id..')',"md",true)  
end
end
if text == 'السورس' or text == 'سورس' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'للاشتراك في السورس', url = 't.me/JTTTZ'}, 
},
}
}
local Jacksors = redis:get(Jack..'sors') or "لا توجد كليشة سورس"

return LuaTele.sendText(msg_chat_id, msg_id,Jacksors,"md", false, false, false, false, reply_markup)
elseif text == 'الاوامر' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '{ 𝟏 ', data = msg.sender.user_id..'/help1'}, {text = '{ 𝟐 ', data = msg.sender.user_id..'/help2'}, 
},
{
{text = '{ 𝟑 }', data = msg.sender.user_id..'/help3'}, {text = '{ 𝟒 }', data = msg.sender.user_id..'/help4'}, 
},
{
{text = '{ 𝟓 }', data = msg.sender.user_id..'/help5'}, {text = '{ الالعاب }', data = msg.sender.user_id..'/help6'}, 
},
{
{text = '{ اوامر القفل / الفتح }', data = msg.sender.user_id..'/NoNextSeting'}, {text = '{ اوامر التعطيل / التفعيل }', data = msg.sender.user_id..'/listallAddorrem'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id, [[
• توجد ↤︎ 5 اوامر في البوت
━━━━━━━━━━━━
• ارسل { م1 } ↤︎ اوامر الحمايه
• ارسل { م2 } ↤︎ اوامر الادمنيه
• ارسل { م3 } ↤︎ اوامر المدراء
• ارسل { م4 } ↤︎ اوامر المنشئين
• ارسل { م5 } ↤︎ اوامر مطورين البوت
]],"md",false, false, false, false, reply_markup)
end
if text == 'تحديث' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
print('Chat Id : '..msg_chat_id)
print('User Id : '..msg_user_send_id)
LuaTele.sendText(msg_chat_id,msg_id, "•  تم تحديث الملفات ♻","md",true)
dofile('lua Jack.lua')  
end
if text == "ضع اسم البوت" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:setex(Jack.."Jack:Change:Name:Bot"..msg.sender.user_id,300,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"•  ارسل لي الاسم الان ","md",true)  
end
if text == "حذف اسم البوت" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Name:Bot") 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حذف اسم البوت ","md",true)   
end
if text == (redis:get(Jack.."Jack:Name:Bot") or "جاك") then
local NamesBot = (redis:get(Jack.."Jack:Name:Bot") or "جاك")
local NameBots = {
"عمر "..NamesBot.. " شتريد؟",
"أჂ̤ أჂ̤ هياتني اني",
"موجود بس لتصيح",
"لتلح دا احجي ويه بنات سكر بعدين اجاوبك",
"راح نموت بكورونا ونته بعدك تصيح "..NamesBot,
'يمعود والله نعسان'
}
return LuaTele.sendText(msg_chat_id,msg_id, NameBots[math.random(#NameBots)],"md",true)  
end
if text == "بوت" then
local NamesBot = (redis:get(Jack.."Jack:Name:Bot") or "جاك")
local BotName = {
"باوع لك خليني احبك وصيحلي باسمي "..NamesBot,
"لتخليني ارجع لحركاتي لقديمه وردا ترا اسمي "..NamesBot.. "",
"راح نموت بكورونا ونته بعدك تصيح بوت"
}
return LuaTele.sendText(msg_chat_id,msg_id,BotName[math.random(#BotName)],"md",true)   
end
if text == 'تنظيف المشتركين' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
local list = redis:smembers(Jack.."users")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
local ChatAction = LuaTele.sendChatAction(v,'Typing')
if ChatAction.luatele ~= "ok" then
x = x + 1
redis:srem(Jack..'users',v)
end
end
if x ~= 0 then
return LuaTele.sendText(msg_chat_id,msg_id,'• العدد الكلي  '..#list..' \n• تم العثور على  '..x..'  من المشتركين حاظرين البوت',"md")
else
return LuaTele.sendText(msg_chat_id,msg_id,'• العدد الكلي  '..#list..' \n• لم يتم العثور على وهميين',"md")
end
end
if text == 'تنظيف المجموعات' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
local list = redis:smembers(Jack.."group:ids")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
if Get_Chat.id then
local statusMem = LuaTele.getChatMember(Get_Chat.id,Jack)
if statusMem.status.luatele == "chatMemberStatusMember" then
x = x + 1
LuaTele.sendText(Get_Chat.id,0,'• البوت عضو في المجموعه سوف اغادر ويمكنك تفعيلي مره اخرى ',"md")
redis:srem(Jack..'group:ids',Get_Chat.id)
local keys = redis:keys(Jack..'*'..Get_Chat.id)
for i = 1, #keys do
redis:del(keys[i])
end
LuaTele.leaveChat(Get_Chat.id)
end
else
x = x + 1
local keys = redis:keys(Jack..'*'..v)
for i = 1, #keys do
redis:del(keys[i])
end
redis:srem(Jack..'group:ids',v)
LuaTele.leaveChat(v)
end
end
if x ~= 0 then
return LuaTele.sendText(msg_chat_id,msg_id,'• العدد الكلي  '..#list..'  للمجموعات \n• تم العثور على  '..x..'  مجموعات البوت ليس ادمن \n• تم تعطيل المجموعه ومغادره البوت من الوهمي ',"md")
else
return LuaTele.sendText(msg_chat_id,msg_id,'• العدد الكلي  '..#list..'  للمجموعات \n• لا توجد مجموعات وهميه',"md")
end
end
end
---تجارب الالعاب--
if text and redis:get(Jack.."replay"..msg.chat_id) then 
local Replay = 0
Replay = redis:smembers(Jack..':ReplayRandom:'..text) 
if #Replay ~= 0 then 
local Replay = Replay[math.random(#Replay)]
Replay = convert_Klmat(msg,data,Replay,true)
local CaptionFilter = Replay:gsub(":Text:",""):gsub(":Document:",""):gsub(":Voice:",""):gsub(":Photo:",""):gsub(":Animation:",""):gsub(":Audio:",""):gsub(":Sticker:",""):gsub(":Video:","")
Caption = redis:hget(Jack..':caption_replay:Random:'..text,CaptionFilter)
Caption = convert_Klmat(msg,data,Caption)
if Replay:match(":Text:") then
return LuaTele.sendText(msg.chat_id,msg.id,Flter_Markdown(Replay:gsub(":Text:","")))
elseif Replay:match(":Document:") then 
return sendDocument(msg.chat_id,msg.id,Replay:gsub(":Document:",""),Caption,"")  
elseif Replay:match(":Photo:") then 
return LuaTele.sendPhoto(msg.chat_id,msg.id,Replay:gsub(":Photo:",""),Caption,"")  
elseif Replay:match(":Voice:") then 
return LuaTele.sendVoice(msg.chat_id,msg.id,Replay:gsub(":Voice:",""),Caption,"")
elseif Replay:match(":Animation:") then 
return LuaTele.sendAnimation(msg.chat_id,msg.id,Replay:gsub(":Animation:",""),Caption,"")  
elseif Replay:match(":Audio:") then 
return LuaTele.sendAudio(msg.chat_id,msg.id,Replay:gsub(":Audio:",""),"",Caption,"")  
elseif Replay:match(":Sticker:") then 
return LuaTele.sendSticker(msg.chat_id,msg.id,Replay:gsub(":Sticker:",""))  
elseif Replay:match(":Video:") then 
return LuaTele.sendVideo(msg.chat_id,msg.id,Replay:gsub(":Video:",""),Caption,"")
end
end
--نهاية تجارب الالعاب--
if text and text:match("^بيع نقاطي (%d+)$") then
local NumGame = text:match("^بيع نقاطي (%d+)$") 
if tonumber(NumGame) == tonumber(0) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• لا استطيع البيع اقل من 1 ","md",true)  
end
local NumberGame = redis:get(Jack.."Jack:Num:Add:Games"..msg.chat_id..msg.sender.user_id)
if tonumber(NumberGame) == tonumber(0) then
return LuaTele.sendText(msg_chat_id,msg_id,"• ليس لديك نقاط من الالعاب \n• اذا كنت تريد ربح النقاط \n• ارسل الالعاب وابدأ اللعب ! ","md",true)  
end
if tonumber(NumGame) > tonumber(NumberGame) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• ليس لديك جواهر بهذا العدد \n• لزيادة مجوهراتك في اللعبه \n• ارسل الالعاب وابدأ اللعب !","md",true)   
end
local NumberGet = (NumGame * 50)
redis:decrby(Jack.."Jack:Num:Add:Games"..msg.chat_id..msg.sender.user_id,NumGame)  
redis:incrby(Jack.."msgs:"..msg.chat_id..":"..msg.sender.user_id,NumGame)  
return LuaTele.sendText(msg_chat_id,msg_id,"• تم خصم ~  "..NumGame.."  من مجوهراتك \n• وتم اضافة ~  "..(NumGame * 50).."  رساله الى رسالك ","md",true)  
end 
if text and text:match("^اضف نقاط (%d+)$") and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على البوت ","md",true)  
end
redis:incrby(Jack.."Jack:Num:Add:Games"..msg.chat_id..Message_Reply.sender.user_id, text:match("^اضف نقاط (%d+)$"))  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم اضافه له  "..text:match("^اضف نقاط (%d+)$").." } من المجوهرات").Reply,"md",true)  
end
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(7)..' 〗 فقط . ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n• عذراً لا تستطيع استخدام الامر على البوت ","md",true)  
end
redis:incrby(Jack.."msgs:"..msg.chat_id..":"..Message_Reply.sender.user_id, text:match("^اضف رسائل (%d+)$"))  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"• تم اضافه له  "..text:match("^اضف رسائل (%d+)$").." } من الرسائل").Reply,"md",true)  
end
if text == "نقاطي" then 
local Num = redis:get(Jack.."Jack:Num:Add:Games"..msg.chat_id..msg.sender.user_id) or 0
if Num == 0 then 
return LuaTele.sendText(msg_chat_id,msg_id, "• لم تفز بأي نقطه ","md",true)  
else
return LuaTele.sendText(msg_chat_id,msg_id, "• عدد النقاط التي ربحتها ↤︎ "..Num.." ","md",true)  
end
end

if text == 'ترتيب الاوامر' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(6)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Get:Reides:Commands:Group"..msg_chat_id..":"..'تعط','تعطيل الايدي بالصوره')
redis:set(Jack.."Jack:Get:Reides:Commands:Group"..msg_chat_id..":"..'تفع','تفعيل الايدي بالصوره')
redis:set(Jack.."Jack:Get:Reides:Commands:Group"..msg_chat_id..":"..'ا','ايدي')
redis:set(Jack.."Jack:Get:Reides:Commands:Group"..msg_chat_id..":"..'م','رفع مميز')
redis:set(Jack.."Jack:Get:Reides:Commands:Group"..msg_chat_id..":"..'اد', 'رفع ادمن')
redis:set(Jack.."Jack:Get:Reides:Commands:Group"..msg_chat_id..":"..'مد','رفع مدير')
redis:set(Jack.."Jack:Get:Reides:Commands:Group"..msg_chat_id..":"..'من', 'رفع منشئ')
redis:set(Jack.."Jack:Get:Reides:Commands:Group"..msg_chat_id..":"..'اس', 'رفع منشئ اساسي')
return LuaTele.sendText(msg_chat_id,msg_id,[[
• تم ترتيب الاوامر بالشكل التالي •
- ايدي - ا •
- مميز - م •
- ادمن - اد •
- مدير - مد • 
- منشى - من •
- المنشئ الاساسي - اس  •
- تعطيل الايدي بالصوره - تعط •
- تفعيل الايدي بالصوره - تفع •
]],"md")
end

end -- GroupBot
if chat_type(msg.chat_id) == "UserBot" then 
if text == 'تحديث الملفات' or text == 'تحديث' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
print('Chat Id : '..msg_chat_id)
print('User Id : '..msg_user_send_id)
LuaTele.sendText(msg_chat_id,msg_id, "•  تم تحديث الملفات ♻","md",true)
dofile('Jack.lua')  
end
if text == '/start' then
redis:sadd(Jack..'users',msg.sender.user_id)  
if not msg.ControllerBot then
if not redis:get(Jack.."Jack:Start:Bot") then
local CmdStart = '*\n• أهلآ بك في بوت '..(redis:get(Jack.."Jack:Name:Bot") or "جاك")..
'\n• اختصاص البوت حماية المجموعات'..
'\n• لتفعيل البوت عليك اتباع مايلي ...'..
'\n• اضف البوت الى مجموعتك'..
'\n• ارفعه ادمن مشرف'..
'\n• ارسل كلمة  تفعيل  ليتم تفعيل المجموعه'..
'\n• مطور البوت ↤︎ '..UserSudo..'*'
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '➕ اضفني لمجموعتك', url = 't.me/'..UserBot..'?startgroup=new'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,CmdStart,"md",false, false, false, false, reply_markup)
else
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '➕ اضفني لمجموعتك', url = 't.me/'..UserBot..'?startgroup=new'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,redis:get(Jack.."Jack:Start:Bot"),"md",false, false, false, false, reply_markup)
end
else
local reply_markup = LuaTele.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = 'تفعيل التواصل',type = 'text'},{text = 'تعطيل التواصل', type = 'text'},
},
{
{text = 'تفعيل البوت الخدمي',type = 'text'},{text = 'تعطيل البوت الخدمي', type = 'text'},
},
{
{text = 'اذاعه للمجموعات',type = 'text'},{text = 'اذاعه خاص', type = 'text'},
},
{
{text = 'اذاعه بالتوجيه',type = 'text'},{text = 'اذاعه بالتوجيه خاص', type = 'text'},
},
{
{text = 'اذاعه بالتثبيت',type = 'text'},
},
{
{text = 'المطورين الثانويين',type = 'text'},{text = 'المطورين',type = 'text'},{text = 'قائمه العام', type = 'text'},
},
{
{text = 'مسح المطورين الثانويين',type = 'text'},{text = 'مسح المطورين',type = 'text'},{text = 'مسح قائمه العام', type = 'text'},
},
{
{text = 'تغيير اسم البوت',type = 'text'},{text = 'حذف اسم البوت', type = 'text'},
},
{
{text = 'الاحصائيات',type = 'text'},
},
{
{text = 'تعطيل الاذاعه',type = 'text'},{text = 'تفعيل الاذاعه',type = 'text'},
},
{
{text = 'تعطيل المغادره',type = 'text'},{text = 'تفعيل المغادره',type = 'text'},
},
{
{text = 'تغيير م',type = 'text'} 
},
{
{text = 'تغغير كليشه المطور',type = 'text'},{text = 'حذف كليشه المطور', type = 'text'},
},
{
{text = 'تغيير كليشه ستارت',type = 'text'},{text = 'حذف كليشه ستارت', type = 'text'},
},
{
{text = 'تنظيف المجموعات',type = 'text'},{text = 'تنظيف المشتركين', type = 'text'},
},
{
{text = 'جلب النسخه الاحتياطيه',type = 'text'},
},
{
{text = 'اضف رد عام',type = 'text'},{text = 'حذف رد عام', type = 'text'},
},
{
{text = 'الردود العامه',type = 'text'},{text = 'مسح الردود العامه', type = 'text'},
},
{
{text = 'تحديث الملفات',type = 'text'},{text = 'تحديث السورس', type = 'text'},
},
{
{text = 'الغاء الامر',type = 'text'},
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'•  اهلا بك عزيزي المطور ', "md", false, false, false, false, reply_markup)
end
end
if text == 'تنظيف المشتركين' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
local list = redis:smembers(Jack.."users")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
local ChatAction = LuaTele.sendChatAction(v,'Typing')
if ChatAction.luatele ~= "ok" then
x = x + 1
redis:srem(Jack..'users',v)
end
end
if x ~= 0 then
return LuaTele.sendText(msg_chat_id,msg_id,'• العدد الكلي  '..#list..' \n• تم العثور على  '..x..'  من المشتركين حاظرين البوت',"md")
else
return LuaTele.sendText(msg_chat_id,msg_id,'• العدد الكلي  '..#list..' \n• لم يتم العثور على وهميين',"md")
end
end
if text == 'تنظيف المجموعات' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
local list = redis:smembers(Jack.."group:ids")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
if Get_Chat.id then
local statusMem = LuaTele.getChatMember(Get_Chat.id,Jack)
if statusMem.status.luatele == "chatMemberStatusMember" then
x = x + 1
LuaTele.sendText(Get_Chat.id,0,'• البوت عضو في المجموعه سوف اغادر ويمكنك تفعيلي مره اخرى ',"md")
redis:srem(Jack..'group:ids',Get_Chat.id)
local keys = redis:keys(Jack..'*'..Get_Chat.id)
for i = 1, #keys do
redis:del(keys[i])
end
LuaTele.leaveChat(Get_Chat.id)
end
else
x = x + 1
local keys = redis:keys(Jack..'*'..v)
for i = 1, #keys do
redis:del(keys[i])
end
redis:srem(Jack..'group:ids',v)
LuaTele.leaveChat(v)
end
end
if x ~= 0 then
return LuaTele.sendText(msg_chat_id,msg_id,'• العدد الكلي  '..#list..'  للمجموعات \n• تم العثور على  '..x..'  مجموعات البوت ليس ادمن \n• تم تعطيل المجموعه ومغادره البوت من الوهمي ',"md")
else
return LuaTele.sendText(msg_chat_id,msg_id,'• العدد الكلي  '..#list..'  للمجموعات \n• لا توجد مجموعات وهميه',"md")
end
end
if text == 'تغيير كليشه ستارت' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:setex(Jack.."Jack:Change:Start:Bot"..msg.sender.user_id,300,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"•  ارسل لي كليشه Start الان ","md",true)  
end
if text == 'حذف كليشه ستارت' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Start:Bot") 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حذف كليشه Start ","md",true)   
end
if text == 'تغيير اسم البوت' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:setex(Jack.."Jack:Change:Name:Bot"..msg.sender.user_id,300,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"•  ارسل لي الاسم الان ","md",true)  
end
if text == 'حذف اسم البوت' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:Name:Bot") 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حذف اسم البوت ","md",true)   
end
if text and text:match("^تعين عدد الاعضاء (%d+)$") then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack..'Jack:Num:Add:Bot',text:match("تعين عدد الاعضاء (%d+)$") ) 
LuaTele.sendText(msg_chat_id,msg_id,'•  تم تعيين عدد اعضاء تفعيل البوت اكثر من : '..text:match("تعين عدد الاعضاء (%d+)$")..' عضو ',"md",true)  
elseif text =='الاحصائيات' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
LuaTele.sendText(msg_chat_id,msg_id,'• عدد احصائيات البوت الكامله \n━━━━━━━━━━━━\n• عدد المجموعات : '..(redis:scard(Jack..'group:ids') or 0)..'\n• عدد المشتركين : '..(redis:scard(Jack..'users') or 0)..'',"md",true)  
end
if text == 'تغغير كليشه المطور' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack..'Jack:GetTexting:DevJack'..msg_chat_id..':'..msg.sender.user_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,'•  ارسل لي الكليشه الان')
end
if text == 'حذف كليشه المطور' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack..'Jack:Texting:DevJack')
return LuaTele.sendText(msg_chat_id,msg_id,'•  تم حذف كليشه المطور')
end
--اضافات
if text=="اضف رد عامم" or text=="اضف رد عام ➕" then 
redis:setex(Jack..'addrd_all:'..msg.chat_id..msg.sender.user_id,300,true)
redis:del(Jack..'allreplay:'..msg.chat_id..msg.sender.user_id)
return LuaTele.sendText(msg.chat_id,msg.id,"• حسناً الان ارسل كلمة الرد العام \n")
end

--الردود المتعدده
if text=="اضف رد متعدد عام" or text == "اضف رد متعدد عام " then
if not msg.Developers then return LuaTele.sendText(msg.chat_id,msg.id,"• هذا الامر يخص 〖 Dev 〗 فقط  \n") end
if not msg.DevelopersQ and not redis:get(Jack..'lock_reda') then 
return LuaTele.sendText(msg.chat_id,msg.id,"• اضافة الردود مقفوله من قبل Dev  ") 
end
redis:setex(Jack..'addrdRandom1Public:'..msg.chat_id..msg.sender.user_id,1400,true) 
redis:del(Jack..'replay1RandomPublic'..msg.chat_id..msg.sender.user_id)
return LuaTele.sendText(msg.chat_id,msg.id,"• حسناً ,  الان ارسل كلمه الرد للمتعدد العام \n-")
end

if text== "مسح رد متعدد عام" then
if not msg.Developers then return LuaTele.sendText(msg.chat_id,msg.id,"• هذا الامر يخص 〖 Dev,Myth 🎖 〗 فقط  \n") end
if not msg.DevelopersQ and not redis:get(Jack..'lock_reda') then 
return LuaTele.sendText(msg.chat_id,msg.id,"• مسح الردود مقفوله من قبل Dev  " )
end
redis:setex(Jack..':DelrdRandomPublic:'..msg.chat_id..msg.sender.user_id,300,true)
return LuaTele.sendText(msg.chat_id,msg.id,"• حسناً عزيزي  \n• الان ارسل الرد المتعدد العام لمسحها ")
end

if text == "مسح الردود المتعدده العامه" then
if not msg.Developers then return LuaTele.sendText(msg.chat_id,msg.id,"• هذا الامر يخص 〖 Dev,Myth 🎖 〗 فقط  \n") end
if not msg.DevelopersQ and not redis:get(Jack..'lock_reda') then 
return LuaTele.sendText(msg.chat_id,msg.id,"• مسح الردود مقفوله من قبل Dev  ") 
end
local AlRdod = redis:smembers(Jack..':KlmatRRandom:') 
if #AlRdod == 0 then return LuaTele.sendText(msg.chat_id,msg.id,"• الردود المتعدده محذوفه بالفعل\n") end
for k,v in pairs(AlRdod) do redis:del(Jack..":ReplayRandom:"..v) redis:del(Jack..':caption_replay:Random:'..v)  end
redis:del(Jack..':KlmatRRandom:') 
return LuaTele.sendText(msg.chat_id,msg.id,"• أهلا عزيزي "..msg.TheRankCmd.."  \n• تم مسح جميع الردود المتعدده\n")
end

if text == "الردود المتعدده العام" or text == "الردود المتعدده العام " then
if not msg.Developers then return LuaTele.sendText(msg.chat_id,msg.id,"• هذا الامر يخص 〖 Dev,Myth 🎖 〗 فقط  \n") end
if not msg.DevelopersQ and not redis:get(Jack..'lock_reda') then 
return LuaTele.sendText(msg.chat_id,msg.id,"• الردود المتعدده مقفوله من قبل Dev  " )
end
message = "| الردود المتعدده العام :\n\n"
local AlRdod = redis:smembers(Jack..':KlmatRRandom:') 
if #AlRdod == 0 then 
message = message .."| لا توجد ردود متعدده مضافه !\n"
else
for k,v in pairs(AlRdod) do
local incrr = redis:scard(Jack..":ReplayRandom:"..v) 
message = message..k..'- ['..v..'] ↤︎  〖 *'..incrr..'* 〗  رد\n'
end
end
return LuaTele.sendText(msg_chat_id,msg_id,""..message.."\n")  
end



if msg.DevelopersQ and text and redis:get(Jack..'addrdRandom1Public:'..msg.chat_id..msg.sender.user_id) then 
if not redis:get(Jack..'replay1RandomPublic'..msg.chat_id..msg.sender.user_id) then  -- كلمه الرد
if utf8.len(text) > 500 then return LuaTele.sendText(msg.chat_id,msg.id,"• عذرا غير مسموح باضافه كلمه الرد باكثر من 500 حرف \n") end
redis:setex(Jack..'addrdRandomPublic:'..msg.chat_id..msg.sender.user_id,1400,true) 
redis:setex(Jack..'replay1RandomPublic'..msg.chat_id..msg.sender.user_id,1400,text)
LuaTele.sendText(msg.chat_id,msg.id,[[
• حسناً يمكنك اضافة 
( نص,صوره,فيديو,متحركه,بصمه,اغنيه,ملف )
ويمكنك اضافة الرد بتلك الطريقة :
▹ `#الاسم` -  اسم العضو .
▹ `#اليوزر` -  اسم المستخدم .
▹ `#الرسائل` -  عدد رسائل المستخدم .
▹ `#الايدي` -  ايدي المستخدم .
▹ `#الرتبه` -  رتبة المستخدم .
▹ `#التعديل` - عدد تعديلات .
▹ `#النقاط` - نقاط المستخدم .
]],"md",true)  
return false
end
end


function CaptionInsert(msg,input,public)
if msg.content and msg.content.caption then 
if public then
redis:hset(Jack..':caption_replay:Random:'..klma,input,msg.content.caption) 
else
redis:hset(Jack..':caption_replay:Random:'..msg.chat_id..klma,input,msg.content.caption) 
end
end
end

if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo and redis:get(Jack..'addrdRandomPublic:'..msg.chat_id..msg.sender.user_id) and redis:get(Jack..'replay1RandomPublic'..msg.chat_id..msg.sender.user_id) then
klma = redis:get(Jack..'replay1RandomPublic'..msg.chat_id..msg.sender.user_id)
klma = klma
if text == "تم" then
redis:del(Jack..'addrdRandom1Public:'..msg.chat_id..msg.sender.user_id)
redis:del(Jack..'addrdRandomPublic:'..msg.chat_id..msg.sender.user_id)
LuaTele.sendText(msg.chat_id,msg.id,'• تم اضافه رد متعدد متعدد بنجاح \n• يمكنك ارسال (['..klma..']) لأظهار الردود المتعدده .')
redis:del(Jack..'replay1RandomPublic'..msg.chat_id..msg.sender.user_id)
return false
end

local CountRdod = redis:scard(Jack..':ReplayRandom:'..klma) or 1
local CountRdod2 = 250 - tonumber(CountRdod)
local CountRdod = 249 - tonumber(CountRdod)
if CountRdod2 == 0 then 
redis:del(Jack..'addrdRandom1Public:'..msg.chat_id..msg.sender.user_id)
redis:del(Jack..'addrdRandomPublic:'..msg.chat_id..msg.sender.user_id)
LuaTele.sendText(msg.chat_id,msg.id,'• وصلت الحد الاقصى لعدد الردود \n• تم اضافه الرد (['..klma..']) للردود المتعدده .')
redis:del(Jack..'replay1RandomPublic'..msg.chat_id..msg.sender.user_id)
return false
end
if msg.content.luatele == "messagePhoto" then
if msg.content.photo.sizes[3] then 
photo_id = msg.content.photo.sizes[3].photo.remote.id
else 
photo_id = msg.content.photo.sizes[0].photo.remote.id
end
redis:sadd(Jack..':KlmatRRandom:',klma) 
redis:sadd(Jack..':ReplayRandom:'..klma,":Photo:"..photo_id) 
CaptionInsert(msg,photo_id,true)
return LuaTele.sendText(msg.chat_id,msg.id,'• تم اضافة صور للرد باقي '..CountRdod..' \n• ارسل رد اخر او ارسل : `تم` ..')
end
if msg.content.luatele == "messageVoice" then
redis:sadd(Jack..':KlmatRRandom:',klma) 
redis:sadd(Jack..':ReplayRandom:'..klma,":Voice:"..msg.content.voice.voice.remote.id) 
CaptionInsert(msg,msg.content.voice.voice.remote.id,true)
return LuaTele.sendText(msg.chat_id,msg.id,'• تم اضافة البصمه للرد باقي '..CountRdod..' \n•  ارسل رد اخر او ارسل : `تم` .')
end
if msg.content.luatele == "messageAnimation" then
redis:sadd(Jack..':KlmatRRandom:',klma) 
redis:sadd(Jack..':ReplayRandom:'..klma,":Animation:"..msg.content.animation.animation.remote.id) 
CaptionInsert(msg,msg.content.animation.animation.remote.id,true)
return LuaTele.sendText(msg.chat_id,msg.id,'• تم اضافة المتحركه للرد باقي '..CountRdod..' \n• ارسل رد اخر او ارسل : `تم` ..')
end
if msg.content.luatele == "messageVideo" then
redis:sadd(Jack..':KlmatRRandom:',klma) 
redis:sadd(Jack..':ReplayRandom:'..klma,":Video:"..msg.content.video.video.remote.id) 
CaptionInsert(msg,msg.content.video.video.remote.id,true)
return LuaTele.sendText(msg.chat_id,msg.id,'??• تم اضافة الفيديو للرد باقي '..CountRdod..' \n• ارسل رد اخر او ارسل : `تم` ..')
end
if msg.content.luatele == "messageAudio" then
redis:sadd(Jack..':KlmatRRandom:',klma) 
redis:sadd(Jack..':ReplayRandom:'..klma,":Audio:"..msg.content.audio.audio.remote.id) 
CaptionInsert(msg,msg.content.audio.audio.remote.id,true)
return LuaTele.sendText(msg.chat_id,msg.id,'• تم اضافة الصوت للرد باقي '..CountRdod..' \n• ارسل رد اخر او ارسل : `تم` ..')
end
if msg.content.luatele == "messageDocument" then
redis:sadd(Jack..':KlmatRRandom:',klma) 
redis:sadd(Jack..':ReplayRandom:'..klma,":Document:"..msg.content.document_.document_.remote.id) 
CaptionInsert(msg,msg.content.document_.document_.remote.id,true)
return LuaTele.sendText(msg.chat_id,msg.id,'• تم اضافة الملف للرد باقي '..CountRdod..' \n• ارسل رد اخر او ارسل : `تم` ..')  
end
if msg.content.luatele == "messageSticker" then
redis:sadd(Jack..':KlmatRRandom:',klma) 
redis:sadd(Jack..':ReplayRandom:'..klma,":Sticker:"..msg.content.sticker.sticker.remote.id) 
CaptionInsert(msg,msg.content.sticker.sticker.remote.id,true)
return LuaTele.sendText(msg.chat_id,msg.id,'• تم اضافة الملصق للرد باقي '..CountRdod..' \n• ارسل رد اخر او ارسل : `تم` ..')
end  
if text then 
redis:sadd(Jack..':KlmatRRandom:',klma) 
redis:sadd(Jack..':ReplayRandom:'..klma,":Text:"..text) 
CaptionInsert(msg,text,true)
return LuaTele.sendText(msg.chat_id,msg.id,'تم اضافة الرد باقي '..CountRdod..'\n تم اضافة الرد ارسل رد اخر او ارسل : `تم` .\n')
end
end
--نهايه الردود المتعدده
if (text== 'حذف شخصيه') then
function FunctionStatus(arg, data)
redis:del(boss..'Text:Games:anmi'..data.content.photo.sizes[0].photo.remote.id)  
redis:srem(boss.."anmi:Games:Bot",data.content.photo.sizes[0].photo.remote.id)  
LuaTele.sendText(msg.chat_id_, msg.id_,'• تم حذف الشخصيه وحذف الجواب .')
end
run_table({ luatele = 'getMessage', chat_id = chat_id,message_id = tonumber(msg.reply_to_message_id)},FunctionStatus, nil)
return false
end

if (text== 'اضف شخصيه') then
redis:set(Jack.."Add:anmi:Games"..msg.sender.user_id..":"..msg.chat_id,'start')
LuaTele.sendText(msg.chat_id, msg.id,'• ارسل الشخصيه الان ')
return false
end
if (text== "قائمه الشخصيات") then
local list = redis:smembers(Jack.."anmi:Games:Bot")
if #list == 0 then
LuaTele.sendText(msg.chat_id, msg.id, "• لا توجد اسئلة شخصيات ")
return false
end
for k,v in pairs(list) do
LuaTele.sendPhoto(msg.chat_id,msg.id,v,"")
end
end

if (text== "حذف قائمه الشخصيات") then
local list = redis:smembers(Jack.."anmi:Games:Bot")
if #list == 0 then
LuaTele.sendText(msg.chat_id, msg.id, "• لا توجد اسئلة شخصيات لمسحها ")
return false
end
for k,v in pairs(list) do
redis:del(Jack..'Text:Games:anmi'..v)  
redis:srem(Jack.."anmi:Games:Bot",v)  
end
LuaTele.sendText(msg.chat_id, msg.id, "• تم حذف جميع اسئلة الشخصيات ")
end


if redis:get(Jack.."Add:anmi:Games"..msg.sender.user_id..":"..msg.chat_id) == 'start' then
if msg.content.photo then
if msg.content.photo.sizes[3] then  
idPhoto = msg.content.photo.sizes[3].photo.remote.id
else 
idPhoto = msg.content.photo.sizes[0].photo.remote.id
end
redis:set(Jack.."photo:Games"..msg.sender.user_id..":"..msg.chat_id,idPhoto)  
redis:sadd(Jack.."anmi:Games:Bot",idPhoto)  
redis:set(Jack.."Add:anmi:Games"..msg.sender.user_id..":"..msg.chat_id,'started')
LuaTele.sendText(msg.chat_id, msg.id,'• ارسل جواب الشخصيه الان')
return false   
end
end
if redis:get(Jack.."Add:anmi:Games"..msg.sender.user_id..":"..msg.chat_id) == 'started' then
local Id_photo = redis:get(Jack.."photo:Games"..msg.sender.user_id..":"..msg.chat_id)
redis:set(Jack..'Text:Games:anmi'..Id_photo,text)
redis:del(Jack.."Add:anmi:Games"..msg.sender.user_id..":"..msg.chat_id)
LuaTele.sendText(msg.chat_id, msg.id,'• تم حفظ سؤال الشخصيه وتم حفظ الجواب بنجاح ')
return false
end

if redis:get(Jack..'addrd_all:'..msg.chat_id..msg.sender.user_id) then -- استقبال الرد لكل المجموعات
if not redis:get(Jack..'allreplay:'..msg.chat_id..msg.sender.user_id) then -- استقبال كلمه الرد لكل المجموعات
if utf8.len(text) > 500 then 
return LuaTele.sendText(msg.chat_id,msg.id,"• عذرا غير مسموح باضافه كلمه الرد باكثر من 500 حرف \n")
end
redis:hdel(Jack..'replay_photo:group:',text)
redis:hdel(Jack..'replay_voice:group:',text)
redis:hdel(Jack..'replay_animation:group:',text)
redis:hdel(Jack..'replay_audio:group:',text)
redis:hdel(Jack..'replay_sticker:group:',text)
redis:hdel(Jack..'replay_video:group:',text)
redis:hdel(Jack..'replay_files:group:',text)
redis:setex(Jack..'allreplay:'..msg.chat_id..msg.sender.user_id,300,text)
return LuaTele.sendText(msg.chat_id,msg.id,"• حسناً يمكنك اضافة \n [[ نص,صوره,فيديو,متحركه,بصمه,اغنيه,ملف ]] \nويمكنك الرد بتلك الطريقة :\n▹ `#الاسم` -  اسم العضو .\n▹ `#اليوزر` -  اسم المستخدم .\n▹ `#الرسائل` -  عدد رسائل المستخدم .\n▹ `#الايدي` -  ايدي المستخدم .\n▹ `#الرتبه` -  رتبة المستخدم .\n▹ `#التعديل` - عدد تعديلات .\n▹ `#النقاط` - نقاط المستخدم .")
end
end

if text == 'اضف رد عام' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Set:Rd"..msg.sender.user_id..":"..msg_chat_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل الان الكلمه لاضافتها في ردود المطور ","md",true)  
end
if text == 'حذف رد عام' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:Set:On"..msg.sender.user_id..":"..msg_chat_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,"• ارسل الان الكلمه لحذفها من ردود المطور","md",true)  
end
if text=='اذاعه خاص' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:setex(Jack.."Jack:Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف • ملصق • متحركه • صوره
 • فيديو • بصمه الفيديو • بصمه • صوت • رساله ❩
━━━━━━━━━━━━
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=='اذاعه للمجموعات' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:setex(Jack.."Jack:Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف • ملصق • متحركه • صوره
 • فيديو • بصمه الفيديو • بصمه • صوت • رساله ❩
━━━━━━━━━━━━
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=="اذاعه بالتثبيت" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:setex(Jack.."Jack:Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف • ملصق • متحركه • صوره
 • فيديو • بصمه الفيديو • بصمه • صوت • رساله ❩
━━━━━━━━━━━━
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=="اذاعه بالتوجيه" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:setex(Jack.."Jack:Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,"• ارسل لي التوجيه الان\n• ليتم نشره في المجموعات","md",true)  
return false
end

if text=='اذاعه بالتوجيه خاص' then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:setex(Jack.."Jack:Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,"• ارسل لي التوجيه الان\n• ليتم نشره الى المشتركين","md",true)  
return false
end

if text == ("الردود العامه") then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
local list = redis:smembers(Jack.."Jack:List:Rd:Sudo")
text = "\n📝︙قائمة ردود المطور \n━━━━━━━━━━━━\n"
for k,v in pairs(list) do
if redis:get(Jack.."Jack:Add:Rd:Sudo:Gif"..v) then
db = "متحركه 🎭"
elseif redis:get(Jack.."Jack:Add:Rd:Sudo:vico"..v) then
db = "بصمه 📢"
elseif redis:get(Jack.."Jack:Add:Rd:Sudo:stekr"..v) then
db = "ملصق 🃏"
elseif redis:get(Jack.."Jack:Add:Rd:Sudo:Text"..v) then
db = "رساله ✉"
elseif redis:get(Jack.."Jack:Add:Rd:Sudo:Photo"..v) then
db = "صوره 🎇"
elseif redis:get(Jack.."Jack:Add:Rd:Sudo:Video"..v) then
db = "فيديو 📹"
elseif redis:get(Jack.."Jack:Add:Rd:Sudo:File"..v) then
db = "ملف"
elseif redis:get(Jack.."Jack:Add:Rd:Sudo:Audio"..v) then
db = "اغنيه 🎵"
elseif redis:get(Jack.."Jack:Add:Rd:Sudo:video_note"..v) then
db = "بصمه فيديو 🎥"
end
text = text..""..k.." » "..v.." » "..db.."\n"
end
if #list == 0 then
text = "• لا توجد ردود للمطور"
end
return LuaTele.sendText(msg_chat_id,msg_id,"["..text.."]","md",true)  
end
if text == ("مسح الردود العامه") then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
local list = redis:smembers(Jack.."Jack:List:Rd:Sudo")
for k,v in pairs(list) do
redis:del(Jack.."Jack:Add:Rd:Sudo:Gif"..v)   
redis:del(Jack.."Jack:Add:Rd:Sudo:vico"..v)   
redis:del(Jack.."Jack:Add:Rd:Sudo:stekr"..v)     
redis:del(Jack.."Jack:Add:Rd:Sudo:Text"..v)   
redis:del(Jack.."Jack:Add:Rd:Sudo:Photo"..v)
redis:del(Jack.."Jack:Add:Rd:Sudo:Video"..v)
redis:del(Jack.."Jack:Add:Rd:Sudo:File"..v)
redis:del(Jack.."Jack:Add:Rd:Sudo:Audio"..v)
redis:del(Jack.."Jack:Add:Rd:Sudo:video_note"..v)
redis:del(Jack.."Jack:List:Rd:Sudo")
end
return LuaTele.sendText(msg_chat_id,msg_id,"• تم حذف ردود المطور","md",true)  
end
if text == 'مسح المطورين' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack.."Jack:Developers:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مطورين حاليا , ","md",true)  
end
redis:del(Jack.."Jack:Developers:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم مسح "..#Info_Members.." من المطورين ","md",true)
end
if text == 'مسح المطورين الثانويين' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack.."Jack:DevelopersQ:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مطورين حاليا , ","md",true)  
end
redis:del(Jack.."Jack:DevelopersQ:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم مسح "..#Info_Members.." من المطورين ","md",true)
end
if text == 'مسح قائمه العام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack.."Jack:BanAll:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد محظورين عام حاليا , ","md",true)  
end
redis:del(Jack.."Jack:BanAll:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم مسح "..#Info_Members.." من المحظورين عام ","md",true)
end
if text == 'تعطيل البوت الخدمي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:BotFree") 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل البوت الخدمي ","md",true)
end
if text == 'تعطيل التواصل' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:del(Jack.."Jack:TwaslBot") 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تعطيل التواصل داخل البوت ","md",true)
end
if text == 'تفعيل البوت الخدمي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:BotFree",true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل البوت الخدمي ","md",true)
end
if text == 'تفعيل التواصل' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
redis:set(Jack.."Jack:TwaslBot",true) 
return LuaTele.sendText(msg_chat_id,msg_id,"• تم تفعيل التواصل داخل البوت ","md",true)
end
if text == 'قائمه العام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack.."Jack:BanAll:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد محظورين عام حاليا , ","md",true)  
end
ListMembers = '\n• قائمه المحظورين عام  \n ━━━━━━━━━━━━\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
var(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المحظورين عام', data = msg.sender.user_id..'/BanAll'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, "md", false, false, false, false, reply_markup)
end
if text == 'المطورين' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack.."Jack:Developers:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مطورين حاليا , ","md",true)  
end
ListMembers = '\n• قائمه مطورين البوت \n ━━━━━━━━━━━━\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المطورين', data = msg.sender.user_id..'/Developers'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, "md", false, false, false, false, reply_markup)
end
if text == 'المطورين الثانويين' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n• عذراً الامر يخص ↤︎ 〖  '..Controller_Num(1)..' 〗 فقط . ',"md",true)  
end
local Info_Members = redis:smembers(Jack.."Jack:DevelopersQ:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"• لا يوجد مطورين حاليا , ","md",true)  
end
ListMembers = '\n• قائمه مطورين البوت \n ━━━━━━━━━━━━\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers..""..k.." - [@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers..""..k.." - ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المطورين', data = msg.sender.user_id..'/Developers'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, "md", false, false, false, false, reply_markup)
end
if not msg.ControllerBot then
if redis:get(Jack.."Jack:TwaslBot") and not redis:sismember(Jack.."Jack:BaN:In:Tuasl",msg.sender.user_id) then
local ListGet = {Sudo_Id,msg.sender.user_id}
local IdSudo = LuaTele.getChat(ListGet[1]).id
local IdUser = LuaTele.getChat(ListGet[2]).id
local FedMsg = LuaTele.sendForwarded(IdSudo, 0, IdUser, msg_id)
redis:setex(Jack.."Jack:Twasl:UserId"..msg.date,172800,IdUser)
if FedMsg.content.luatele == "messageSticker" then
LuaTele.sendText(IdSudo,0,Reply_Status(IdUser,'• قام بارسال الملصق').Reply,"md",true)  
end
return LuaTele.sendText(IdUser,msg_id,Reply_Status(IdUser,'• تم ارسال رسالتك الى المطور').Reply,"md",true)  
end
else 
if msg.reply_to_message_id ~= 0 then
local Message_Get = LuaTele.getMessage(msg_chat_id, msg.reply_to_message_id)
if Message_Get.forward_info then
local Info_User = redis:get(Jack.."Jack:Twasl:UserId"..Message_Get.forward_info.date) or 46899864
if text == 'حظر' then
redis:sadd(Jack..'Jack:BaN:In:Tuasl',Info_User)  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Info_User,'• تم حظره من تواصل البوت ').Reply,"md",true)  
end 
if text =='الغاء الحظر' or text =='الغاء حظر' then
redis:srem(Jack..'Jack:BaN:In:Tuasl',Info_User)  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Info_User,'• تم الغاء حظره من تواصل البوت ').Reply,"md",true)  
end 
local ChatAction = LuaTele.sendChatAction(Info_User,'Typing')
if not Info_User or ChatAction.message == "USER_IS_BLOCKED" then
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Info_User,'• قام بحظر البوت لا استطيع ارسال رسالتك ').Reply,"md",true)  
end
if msg.content.video_note then
LuaTele.sendVideoNote(Info_User, 0, msg.content.video_note.video.remote.id)
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
LuaTele.sendPhoto(Info_User, 0, idPhoto,'')
elseif msg.content.sticker then 
LuaTele.sendSticker(Info_User, 0, msg.content.sticker.sticker.remote.id)
elseif msg.content.voice_note then 
LuaTele.sendVoiceNote(Info_User, 0, msg.content.voice_note.voice.remote.id, '', "md")
elseif msg.content.video then 
LuaTele.sendVideo(Info_User, 0, msg.content.video.video.remote.id, '', "md")
elseif msg.content.animation then 
LuaTele.sendAnimation(Info_User,0, msg.content.animation.animation.remote.id, '', "md")
elseif msg.content.document then
LuaTele.sendDocument(Info_User, 0, msg.content.document.document.remote.id, '', "md")
elseif msg.content.audio then
LuaTele.sendAudio(Info_User, 0, msg.content.audio.audio.remote.id, '', "md") 
elseif text then
LuaTele.sendText(Info_User,0,text,"md",true)
end 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Info_User,'• تم ارسال رسالتك اليه ').Reply,"md",true)  
end
end
end 
end --UserBot
end -- File_Bot_Run


function CallBackLua(data) --- هذا الكالباك بي الابديت
--var(data)

if data and data.luatele and data.luatele == "updateSupergroup" then
local Get_Chat = LuaTele.getChat('-100'..data.supergroup.id)
if data.supergroup.status.luatele == "chatMemberStatusBanned" then
redis:srem(Jack.."group:ids",'-100'..data.supergroup.id)
local keys = redis:keys(Jack..'*'..'-100'..data.supergroup.id..'*')
redis:del(Jack.."Jack:List:Manager"..'-100'..data.supergroup.id)
redis:del(Jack.."Jack:Command:List:Group"..'-100'..data.supergroup.id)
for i = 1, #keys do 
redis:del(keys[i])
end
return LuaTele.sendText(Sudo_Id,0,'\n• تم طرد البوت من مجموعه جديده \n• اسم المجموعه : '..Get_Chat.title..'\n• ايدي المجموعه :*`-100'..data.supergroup.id..'`\n• تم مسح جميع البيانات المتعلقه بالمجموعه',"md")
end
elseif data and data.luatele and data.luatele == "updateMessageSendSucceeded" then
local msg = data.message
local Chat = msg.chat_id
if msg.content.text then
text = msg.content.text.text
end
if msg.content.video_note then
if msg.content.video_note.video.remote.id == redis:get(Jack.."Jack:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
redis:del(Jack.."Jack:PinMsegees:"..msg.chat_id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
if idPhoto == redis:get(Jack.."Jack:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
redis:del(Jack.."Jack:PinMsegees:"..msg.chat_id)
end
elseif msg.content.sticker then 
if msg.content.sticker.sticker.remote.id == redis:get(Jack.."Jack:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
redis:del(Jack.."Jack:PinMsegees:"..msg.chat_id)
end
elseif msg.content.voice_note then 
if msg.content.voice_note.voice.remote.id == redis:get(Jack.."Jack:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
redis:del(Jack.."Jack:PinMsegees:"..msg.chat_id)
end
elseif msg.content.video then 
if msg.content.video.video.remote.id == redis:get(Jack.."Jack:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
redis:del(Jack.."Jack:PinMsegees:"..msg.chat_id)
end
elseif msg.content.animation then 
if msg.content.animation.animation.remote.id ==  redis:get(Jack.."Jack:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
redis:del(Jack.."Jack:PinMsegees:"..msg.chat_id)
end
elseif msg.content.document then
if msg.content.document.document.remote.id == redis:get(Jack.."Jack:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
redis:del(Jack.."Jack:PinMsegees:"..msg.chat_id)
end
elseif msg.content.audio then
if msg.content.audio.audio.remote.id == redis:get(Jack.."Jack:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
redis:del(Jack.."Jack:PinMsegees:"..msg.chat_id)
end
elseif text then
if text == redis:get(Jack.."Jack:PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
redis:del(Jack.."Jack:PinMsegees:"..msg.chat_id)
end
end
elseif data and data.luatele and data.luatele == "updateNewMessage" then
if data.message.content.luatele == "messageChatDeleteMember" or data.message.content.luatele == "messageChatAddMembers" or data.message.content.luatele == "messagePinMessage" or data.message.content.luatele == "messageChatChangeTitle" or data.message.content.luatele == "messageChatJoinByLink" then
if redis:get(Jack.."Jack:Lock:tagservr"..data.message.chat_id) then
LuaTele.deleteMessages(data.message.chat_id,{[1]= data.message.id})
end
end 
if tonumber(data.message.sender.user_id) == tonumber(Jack) then
return false
end
if data.message.content.luatele == "messageChatJoinByLink" and redis:get(Jack..'Jack:Status:joinet'..data.message.chat_id) == 'true' then
    local reply_markup = LuaTele.replyMarkup{
    type = 'inline',
    data = {
    {
    {text = ' انا لست بوت ', data = data.message.sender.user_id..'/UnKed'},
    },
    }
    } 
    LuaTele.setChatMemberStatus(data.message.chat_id,data.message.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
    return LuaTele.sendText(data.message.chat_id, data.message.id, '• عليك اختيار انا لست بوت لتخطي نضام التحقق', "md",false, false, false, false, reply_markup)
    end
File_Bot_Run(data.message,data.message)
elseif data and data.luatele and data.luatele == "updateMessageEdited" then
-- data.chat_id -- data.message_id
local Message_Edit = LuaTele.getMessage(data.chat_id, data.message_id)
if Message_Edit.sender.user_id == Jack then
print('This is Edit for Bot')
return false
end
File_Bot_Run(Message_Edit,Message_Edit)
redis:incr(Jack..'Jack:Num:Message:Edit'..data.chat_id..Message_Edit.sender.user_id)
if Message_Edit.content.luatele == "messageContact" or Message_Edit.content.luatele == "messageVideoNote" or Message_Edit.content.luatele == "messageDocument" or Message_Edit.content.luatele == "messageAudio" or Message_Edit.content.luatele == "messageVideo" or Message_Edit.content.luatele == "messageVoiceNote" or Message_Edit.content.luatele == "messageAnimation" or Message_Edit.content.luatele == "messagePhoto" then
if redis:get(Jack.."Jack:Lock:edit"..data.chat_id) then
LuaTele.deleteMessages(data.chat_id,{[1]= data.message_id})
end
end
elseif data and data.luatele and data.luatele == "updateNewCallbackQuery" then
-- data.chat_id
-- data.payload.data
-- data.sender_user_id
Text = LuaTele.base64_decode(data.payload.data)
IdUser = data.sender_user_id
ChatId = data.chat_id
Msg_id = data.message_id
if Text and Text:match('(%d+)/UnKed') then
    local UserId = Text:match('(%d+)/UnKed')
    if tonumber(UserId) ~= tonumber(IdUser) then
    return LuaTele.answerCallbackQuery(data.id, "• الامر لا يخصك", true)
    end
    LuaTele.setChatMemberStatus(ChatId,UserId,'restricted',{1,1,1,1,1,1,1,1})
    return LuaTele.editMessageText(ChatId,Msg_id,"• تم التحقق منك اجابتك صحيحه يمكنك الدردشه الان", "md", false)
    end
if Text and Text:match('(%d+)/help1') then
local UserId = Text:match('(%d+)/help1')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '{ 𝟏 }', data = IdUser..'/help1'}, {text = '{ 𝟐 }', data = IdUser..'/help2'}, 
},
{
{text = '{ 𝟑 }', data = IdUser..'/help3'}, {text = '{ 𝟒 }', data = IdUser..'/help4'}, 
},
{
{text = '{ 𝟓 }', data = IdUser..'/help5'}, {text = '{ الالعاب }', data = IdUser..'/help6'}, 
},
{
{text = '{ القائمه الرئيسيه }', data = IdUser..'/helpall'},
},
}
}
local TextHelp = [[
• اوامر الحمايه اتبع مايلي ...
━━━━━━━━━━━━
• قفل - فتح ↤︎ الامر 
• تستطيع قفل حمايه كما يلي ...
• ↤︎ { بالتقيد - بالطرد - بالكتم }
━━━━━━━━━━━━
• الروابط
• المعرف
• التاك
• الشارحه
• التعديل
• التثبيت
• المتحركه
• الملفات
• الصور
━━━━━━━━━━━━
• الماركداون
• البوتات
• التكرار
• الكلايش
• السيلفي
• الملصقات
• الفيديو
• الانلاين
• الدردشه
━━━━━━━━━━━━
• التوجيه
• الاغاني
• الصوت
• الجهات
• الاشعارات
]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help2') then
local UserId = Text:match('(%d+)/help2')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '{ 𝟏 }', data = IdUser..'/help1'}, {text = '{ 𝟐 }', data = IdUser..'/help2'}, 
},
{
{text = '{ 𝟑 }', data = IdUser..'/help3'}, {text = '{ 𝟒 }', data = IdUser..'/help4'}, 
},
{
{text = '{ 𝟓 }', data = IdUser..'/help5'}, {text = '{ الالعاب }', data = IdUser..'/help6'}, 
},
{
{text = '{ القائمه الرئيسيه }', data = IdUser..'/helpall'},
},
}
}
local TextHelp = [[
• اوامر ادمنية المجموعه ...
━━━━━━━━━━━━
• رفع- تنزيل ↤︎ مميز
• تاك للكل - عدد القروب
• كتم - حظر - طرد - تقيد
• الغاء كتم - الغاء حظر - الغاء تقيد
• منع - الغاء منع 
━━━━━━━━━━━━
• عرض القوائم كما يلي ...
━━━━━━━━━━━━
• المكتومين
• المميزين 
• قائمه المنع
━━━━━━━━━━━━
• تثبيت - الغاء تثبيت
• الرابط - الاعدادات
• الترحيب - القوانين
• تفعيل - تعطيل ↤︎ الترحيب
• تفعيل - تعطيل ↤︎ الرابط
• جهاتي -ايدي - رسائلي
• سحكاتي - نقاطي
• كشف البوتات
━━━━━━━━━━━━
• وضع - ضع ↤︎ الاوامر التاليه 
• اسم - رابط - صوره
• قوانين - وصف - ترحيب
━━━━━━━━━━━━
• حذف - مسح ↤︎ الاوامر التاليه
• قائمه المنع - المحظورين 
• المميزين - المكتومين - القوانين
• المطرودين - البوتات - الصوره
• الرابط
]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help3') then
local UserId = Text:match('(%d+)/help3')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '{ 𝟏 }', data = IdUser..'/help1'}, {text = '{ 𝟐 }', data = IdUser..'/help2'}, 
},
{
{text = '{ 𝟑 }', data = IdUser..'/help3'}, {text = '{ 𝟒 }', data = IdUser..'/help4'}, 
},
{
{text = '{ 𝟓 }', data = IdUser..'/help5'}, {text = '{ الالعاب }', data = IdUser..'/help6'}, 
},
{
{text = '{ القائمه الرئيسيه }', data = IdUser..'/helpall'},
},
}
}
local TextHelp = [[
• اوامر المدراء في المجموعه
━━━━━━━━━━━━
• رفع - تنزيل ↤︎ ادمن
• الادمنيه 
▽️︙رفع- كشف ↤︎ القيود
• تنزيل الكل ↤︎ { بالرد - بالمعرف }
━━━━━━━━━━━━
• لتغيير رد الرتب في البوت
━━━━━━━━━━━━
• تغير رد ↤︎ {اسم الرتبه والنص} 
• المطور - المنشئ الاساسي
• المنشئ - المدير - الادمن
• المميز - العضو
━━━━━━━━━━━━
• تفعيل - تعطيل ↤︎ الاوامر التاليه ↓
━━━━━━━━━━━━
• الايدي - الايدي بالصوره
• ردود المطور - ردود المدير
• اطردني - الالعاب - الرفع
• الحظر - الرابط -
━━━━━━━━━━━━
• تعين - مسح ↤︎{ الايدي }
• رفع الادمنيه - مسح الادمنيه
• ردود المدير - مسح ردود المدير
• اضف - حذف ↤︎ { رد }
• مسح ↤︎ { عدد }
]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help4') then
local UserId = Text:match('(%d+)/help4')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '{ 𝟏 }', data = IdUser..'/help1'}, {text = '{ 𝟐 }', data = IdUser..'/help2'}, 
},
{
{text = '{ 𝟑 }', data = IdUser..'/help3'}, {text = '{ 𝟒 }', data = IdUser..'/help4'}, 
},
{
{text = '{ 𝟓 }', data = IdUser..'/help5'}, {text = '{ الالعاب }', data = IdUser..'/help6'}, 
},
{
{text = '{ القائمه الرئيسيه }', data = IdUser..'/helpall'},
},
}
}
local TextHelp = [[
• اوامر المنشئ الاساسي
━━━━━━━━━━━━
• رفع - تنزيل ↤︎{ منشئ }
• المنشئين - مسح المنشئين
━━━━━━━━━━━━
• اوامر المنشئ المجموعه
━━━━━━━━━━━━
• رفع - تنزيل ↤︎ { مدير }
• المدراء - مسح المدراء
• اضف رسائل ↤︎ { بالرد او الايدي }
• اضف نقاط ↤︎ { بالرد او الايدي }
• اضف - حذف ↤︎ { امر }
• الاوامر المضافه - مسح الاوامر المضافه
]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help5') then
local UserId = Text:match('(%d+)/help5')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '{ 𝟏 }', data = IdUser..'/help1'}, {text = '{ 𝟐 }', data = IdUser..'/help2'}, 
},
{
{text = '{ 𝟑 }', data = IdUser..'/help3'}, {text = '{ 𝟒 }', data = IdUser..'/help4'}, 
},
{
{text = '{ 𝟓 }', data = IdUser..'/help5'}, {text = '{ الالعاب }', data = IdUser..'/help6'}, 
},
{
{text = '{ القائمه الرئيسيه }', data = IdUser..'/helpall'},
},
}
}
local TextHelp = [[
• اوامر المطور الاساسي  
━━━━━━━━━━━━
• حظر عام - الغاء العام
• اضف - حذف ↤︎ { مطور } 
• قائمه العام - مسح قائمه العام
• المطورين - مسح المطورين
━━━━━━━━━━━━
• اضف - حذف ↤︎ { رد للكل }
• وضع - حذف ↤︎ { كليشه المطور } 
• مسح ردود المطور - ردود المطور 
• تحديث -  تحديث السورس 
• تعين عدد الاعضاء ↤︎ { العدد }
━━━━━━━━━━━━
• تفعيل - تعطيل ↤︎ { الاوامر التاليه ↓}
• البوت الخدمي - المغادرة - الاذاعه
• ملف ↤︎ { اسم الملف }
━━━━━━━━━━━━
• مسح جميع الملفات 
• المتجر - الملفات
━━━━━━━━━━━━
• اوامر المطور في البوت
━━━━━━━━━━━━
• تفعيل - تعطيل - الاحصائيات
• رفع- تنزيل ↤︎ { منشئ اساسي }
• مسح الاساسين - المنشئين الاساسين 
• غادر - غادر ↤︎ { والايدي }
• اذاعه - اذاعه بالتوجيه - اذاعه بالتثبيت
• اذاعه خاص - اذاعه خاص بالتوجيه 
]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help6') then
local UserId = Text:match('(%d+)/help6')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '{ 𝟏 }', data = IdUser..'/help1'}, {text = '{ 𝟐 }', data = IdUser..'/help2'}, 
},
{
{text = '{ 𝟑 }', data = IdUser..'/help3'}, {text = '{ 𝟒 }', data = IdUser..'/help4'}, 
},
{
{text = '{ 𝟓 }', data = IdUser..'/help5'}, {text = '{ الالعاب }', data = IdUser..'/help6'}, 
},
{
{text = '{ القائمه الرئيسيه }', data = IdUser..'/helpall'},
},
}
}
local TextHelp = [[
• قائمه الالعاب البوت
━━━━━━━━━━━━
• لعبة المختلف » المختلف
• لعبة الامثله » امثله
• لعبة العكس » العكس
• لعبة الحزوره » حزوره
• لعبة المعاني » معاني
• لعبة البات » بات
• لعبة التخمين » خمن
• لعبه الاسرع » الاسرع
• لعبة السمايلات » سمايلات
━━━━━━━━━━━━
• نقاطي ↤︎ لعرض عدد الارباح
• بيع نقاطي ↤︎ { العدد } ↤︎ لبيع كل نقطه مقابل {50} رساله
]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/helpall') then
local UserId = Text:match('(%d+)/helpall')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '{ 𝟏 }', data = IdUser..'/help1'}, {text = '{ 𝟐 }', data = IdUser..'/help2'}, 
},
{
{text = '{ 𝟑 }', data = IdUser..'/help3'}, {text = '{ 𝟒 }', data = IdUser..'/help4'}, 
},
{
{text = '{ 𝟓 }', data = IdUser..'/help5'}, {text = '{ الالعاب }', data = IdUser..'/help6'}, 
},
{
{text = '{ اوامر القفل / الفتح }', data = IdUser..'/NoNextSeting'}, {text = '{ اوامر التعطيل / التفعيل }', data = IdUser..'/listallAddorrem'}, 
},
}
}
local TextHelp = [[
• توجد ↤︎ 5 اوامر في البوت
━━━━━━━━━━━━
• ارسل { م1 } ↤︎ اوامر الحمايه
• ارسل { م2 } ↤︎ اوامر الادمنيه
• ارسل { م3 } ↤︎ اوامر المدراء
• ارسل { م4 } ↤︎ اوامر المنشئين
• ارسل { م5 } ↤︎ اوامر مطورين البوت
]]
LuaTele.editMessageText(ChatId,Msg_id,TextHelp, "md", true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/lock_link') then
local UserId = Text:match('(%d+)/lock_link')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Link"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الروابط").Lock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_spam') then
local UserId = Text:match('(%d+)/lock_spam')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Spam"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الكلايش").Lock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_keypord') then
local UserId = Text:match('(%d+)/lock_keypord')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Keyboard"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الكيبورد").Lock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_voice') then
local UserId = Text:match('(%d+)/lock_voice')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:vico"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الاغاني").Lock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gif') then
local UserId = Text:match('(%d+)/lock_gif')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Animation"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل المتحركات").Lock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_files') then
local UserId = Text:match('(%d+)/lock_files')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Document"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الملفات").Lock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_text') then
local UserId = Text:match('(%d+)/lock_text')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:text"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الدردشه").Lock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_video') then
local UserId = Text:match('(%d+)/lock_video')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Video"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الفيديو").Lock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_photo') then
local UserId = Text:match('(%d+)/lock_photo')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Photo"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الصور").Lock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_username') then
local UserId = Text:match('(%d+)/lock_username')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:User:Name"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل المعرفات").Lock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tags') then
local UserId = Text:match('(%d+)/lock_tags')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:hashtak"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل التاك").Lock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_bots') then
local UserId = Text:match('(%d+)/lock_bots')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Bot:kick"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل البوتات").Lock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fwd') then
local UserId = Text:match('(%d+)/lock_fwd')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:forward"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل التوجيه").Lock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_audio') then
local UserId = Text:match('(%d+)/lock_audio')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Audio"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الصوت").Lock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_stikear') then
local UserId = Text:match('(%d+)/lock_stikear')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Sticker"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الملصقات").Lock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_phone') then
local UserId = Text:match('(%d+)/lock_phone')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Contact"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الجهات").Lock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_joine') then
local UserId = Text:match('(%d+)/lock_joine')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Join"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الدخول").Lock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_addmem') then
local UserId = Text:match('(%d+)/lock_addmem')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:AddMempar"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الاضافه").Lock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videonote') then
local UserId = Text:match('(%d+)/lock_videonote')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Unsupported"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل بصمه الفيديو").Lock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_pin') then
local UserId = Text:match('(%d+)/lock_pin')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:lockpin"..ChatId,(LuaTele.getChatPinnedMessage(ChatId).id or true)) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل التثبيت").Lock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tgservir') then
local UserId = Text:match('(%d+)/lock_tgservir')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:tagservr"..ChatId,true)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الاشعارات").Lock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_markdaun') then
local UserId = Text:match('(%d+)/lock_markdaun')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Markdaun"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الماركدون").Lock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_edits') then
local UserId = Text:match('(%d+)/lock_edits')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:edit"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل التعديل").Lock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_games') then
local UserId = Text:match('(%d+)/lock_games')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:geam"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الالعاب").Lock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_flood') then
local UserId = Text:match('(%d+)/lock_flood')
if tonumber(IdUser) == tonumber(UserId) then
redis:hset(Jack.."Jack:Spam:Group:User"..ChatId ,"Spam:User","del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل التكرار").Lock, "md", true, false, reply_markup)
end
end

if Text and Text:match('(%d+)/lock_linkkid') then
local UserId = Text:match('(%d+)/lock_linkkid')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Link"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الروابط").lockKid, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_spamkid') then
local UserId = Text:match('(%d+)/lock_spamkid')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Spam"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الكلايش").lockKid, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_keypordkid') then
local UserId = Text:match('(%d+)/lock_keypordkid')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Keyboard"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الكيبورد").lockKid, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_voicekid') then
local UserId = Text:match('(%d+)/lock_voicekid')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:vico"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الاغاني").lockKid, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gifkid') then
local UserId = Text:match('(%d+)/lock_gifkid')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Animation"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل المتحركات").lockKid, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fileskid') then
local UserId = Text:match('(%d+)/lock_fileskid')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Document"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الملفات").lockKid, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videokid') then
local UserId = Text:match('(%d+)/lock_videokid')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Video"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الفيديو").lockKid, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_photokid') then
local UserId = Text:match('(%d+)/lock_photokid')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Photo"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الصور").lockKid, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_usernamekid') then
local UserId = Text:match('(%d+)/lock_usernamekid')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:User:Name"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل المعرفات").lockKid, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tagskid') then
local UserId = Text:match('(%d+)/lock_tagskid')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:hashtak"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل التاك").lockKid, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fwdkid') then
local UserId = Text:match('(%d+)/lock_fwdkid')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:forward"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل التوجيه").lockKid, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_audiokid') then
local UserId = Text:match('(%d+)/lock_audiokid')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Audio"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الصوت").lockKid, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_stikearkid') then
local UserId = Text:match('(%d+)/lock_stikearkid')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Sticker"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الملصقات").lockKid, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_phonekid') then
local UserId = Text:match('(%d+)/lock_phonekid')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Contact"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الجهات").lockKid, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videonotekid') then
local UserId = Text:match('(%d+)/lock_videonotekid')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Unsupported"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل بصمه الفيديو").lockKid, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_markdaunkid') then
local UserId = Text:match('(%d+)/lock_markdaunkid')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Markdaun"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الماركدون").lockKid, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gameskid') then
local UserId = Text:match('(%d+)/lock_gameskid')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:geam"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الالعاب").lockKid, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_floodkid') then
local UserId = Text:match('(%d+)/lock_floodkid')
if tonumber(IdUser) == tonumber(UserId) then
redis:hset(Jack.."Jack:Spam:Group:User"..ChatId ,"Spam:User","keed")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل التكرار").lockKid, "md", true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/lock_linkktm') then
local UserId = Text:match('(%d+)/lock_linkktm')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Link"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الروابط").lockKtm, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_spamktm') then
local UserId = Text:match('(%d+)/lock_spamktm')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Spam"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الكلايش").lockKtm, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_keypordktm') then
local UserId = Text:match('(%d+)/lock_keypordktm')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Keyboard"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الكيبورد").lockKtm, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_voicektm') then
local UserId = Text:match('(%d+)/lock_voicektm')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:vico"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الاغاني").lockKtm, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gifktm') then
local UserId = Text:match('(%d+)/lock_gifktm')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Animation"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل المتحركات").lockKtm, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_filesktm') then
local UserId = Text:match('(%d+)/lock_filesktm')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Document"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الملفات").lockKtm, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videoktm') then
local UserId = Text:match('(%d+)/lock_videoktm')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Video"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الفيديو").lockKtm, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_photoktm') then
local UserId = Text:match('(%d+)/lock_photoktm')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Photo"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الصور").lockKtm, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_usernamektm') then
local UserId = Text:match('(%d+)/lock_usernamektm')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:User:Name"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل المعرفات").lockKtm, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tagsktm') then
local UserId = Text:match('(%d+)/lock_tagsktm')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:hashtak"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل التاك").lockKtm, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fwdktm') then
local UserId = Text:match('(%d+)/lock_fwdktm')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:forward"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل التوجيه").lockKtm, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_audioktm') then
local UserId = Text:match('(%d+)/lock_audioktm')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Audio"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الصوت").lockKtm, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_stikearktm') then
local UserId = Text:match('(%d+)/lock_stikearktm')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Sticker"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الملصقات").lockKtm, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_phonektm') then
local UserId = Text:match('(%d+)/lock_phonektm')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Contact"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الجهات").lockKtm, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videonotektm') then
local UserId = Text:match('(%d+)/lock_videonotektm')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Unsupported"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل بصمه الفيديو").lockKtm, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_markdaunktm') then
local UserId = Text:match('(%d+)/lock_markdaunktm')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Markdaun"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الماركدون").lockKtm, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gamesktm') then
local UserId = Text:match('(%d+)/lock_gamesktm')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:geam"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الالعاب").lockKtm, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_floodktm') then
local UserId = Text:match('(%d+)/lock_floodktm')
if tonumber(IdUser) == tonumber(UserId) then
redis:hset(Jack.."Jack:Spam:Group:User"..ChatId ,"Spam:User","mute")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل التكرار").lockKtm, "md", true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/lock_linkkick') then
local UserId = Text:match('(%d+)/lock_linkkick')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Link"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الروابط").lockKick, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_spamkick') then
local UserId = Text:match('(%d+)/lock_spamkick')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Spam"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الكلايش").lockKick, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_keypordkick') then
local UserId = Text:match('(%d+)/lock_keypordkick')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Keyboard"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الكيبورد").lockKick, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_voicekick') then
local UserId = Text:match('(%d+)/lock_voicekick')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:vico"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الاغاني").lockKick, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gifkick') then
local UserId = Text:match('(%d+)/lock_gifkick')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Animation"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل المتحركات").lockKick, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fileskick') then
local UserId = Text:match('(%d+)/lock_fileskick')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Document"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الملفات").lockKick, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videokick') then
local UserId = Text:match('(%d+)/lock_videokick')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Video"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الفيديو").lockKick, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_photokick') then
local UserId = Text:match('(%d+)/lock_photokick')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Photo"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الصور").lockKick, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_usernamekick') then
local UserId = Text:match('(%d+)/lock_usernamekick')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:User:Name"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل المعرفات").lockKick, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tagskick') then
local UserId = Text:match('(%d+)/lock_tagskick')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:hashtak"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل التاك").lockKick, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fwdkick') then
local UserId = Text:match('(%d+)/lock_fwdkick')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:forward"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل التوجيه").lockKick, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_audiokick') then
local UserId = Text:match('(%d+)/lock_audiokick')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Audio"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الصوت").lockKick, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_stikearkick') then
local UserId = Text:match('(%d+)/lock_stikearkick')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Sticker"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الملصقات").lockKick, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_phonekick') then
local UserId = Text:match('(%d+)/lock_phonekick')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Contact"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الجهات").lockKick, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videonotekick') then
local UserId = Text:match('(%d+)/lock_videonotekick')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Unsupported"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل بصمه الفيديو").lockKick, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_markdaunkick') then
local UserId = Text:match('(%d+)/lock_markdaunkick')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:Markdaun"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الماركدون").lockKick, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gameskick') then
local UserId = Text:match('(%d+)/lock_gameskick')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Lock:geam"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل الالعاب").lockKick, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_floodkick') then
local UserId = Text:match('(%d+)/lock_floodkick')
if tonumber(IdUser) == tonumber(UserId) then
redis:hset(Jack.."Jack:Spam:Group:User"..ChatId ,"Spam:User","kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم قفل التكرار").lockKick, "md", true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/unmute_link') then
local UserId = Text:match('(%d+)/unmute_link')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Status:Link"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تعطيل امر الرابط").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_welcome') then
local UserId = Text:match('(%d+)/unmute_welcome')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Status:Welcome"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تعطيل امر الترحيب").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_Id') then
local UserId = Text:match('(%d+)/unmute_Id')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."lock_id"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تعطيل امر الايدي").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_IdPhoto') then
local UserId = Text:match('(%d+)/unmute_IdPhoto')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Status:IdPhoto"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تعطيل امر الايدي بالصوره").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_ryple') then
local UserId = Text:match('(%d+)/unmute_ryple')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Status:Reply"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تعطيل امر ردود المدير").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_ryplesudo') then
local UserId = Text:match('(%d+)/unmute_ryplesudo')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Status:ReplySudo"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تعطيل امر ردود المطور").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_setadmib') then
local UserId = Text:match('(%d+)/unmute_setadmib')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Status:SetId"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تعطيل امر الرفع").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_kickmembars') then
local UserId = Text:match('(%d+)/unmute_kickmembars')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Status:BanId"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تعطيل امر الطرد - الحظر").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_games') then
local UserId = Text:match('(%d+)/unmute_games')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Status:Games"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تعطيل امر الالعاب").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_kickme') then
local UserId = Text:match('(%d+)/unmute_kickme')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Status:KickMe"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تعطيل امر اطردني").unLock, "md", true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/mute_link') then
local UserId = Text:match('(%d+)/mute_link')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Status:Link"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تفعيل امر الرابط").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_welcome') then
local UserId = Text:match('(%d+)/mute_welcome')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Status:Welcome"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تفعيل امر الترحيب").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_Id') then
local UserId = Text:match('(%d+)/mute_Id')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."lock_id"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تفعيل امر الايدي").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_IdPhoto') then
local UserId = Text:match('(%d+)/mute_IdPhoto')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Status:IdPhoto"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تفعيل امر الايدي بالصوره").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_ryple') then
local UserId = Text:match('(%d+)/mute_ryple')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Status:Reply"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تفعيل امر ردود المدير").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_ryplesudo') then
local UserId = Text:match('(%d+)/mute_ryplesudo')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Status:ReplySudo"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تفعيل امر ردود المطور").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_setadmib') then
local UserId = Text:match('(%d+)/mute_setadmib')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Status:SetId"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تفعيل امر الرفع").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_kickmembars') then
local UserId = Text:match('(%d+)/mute_kickmembars')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Status:BanId"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تفعيل امر الطرد - الحظر").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_games') then
local UserId = Text:match('(%d+)/mute_games')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Status:Games"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تفعيل امر الالعاب").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_kickme') then
local UserId = Text:match('(%d+)/mute_kickme')
if tonumber(IdUser) == tonumber(UserId) then
redis:set(Jack.."Jack:Status:KickMe"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم تفعيل امر اطردني").unLock, "md", true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/addAdmins@(.*)') then
local UserId = {Text:match('(%d+)/addAdmins@(.*)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
local Info_Members = LuaTele.getSupergroupMembers(UserId[2], "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
y = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].bot_info == nil then
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
redis:sadd(Jack..":MONSHA_Groupp:"..UserId[2],v.member_id.user_id) 
x = x + 1
else
redis:sadd(Jack.."Jack:Addictive:Group"..UserId[2],v.member_id.user_id) 
y = y + 1
end
end
end
LuaTele.answerCallbackQuery(data.id, "• تم ترقيه "..y.." ادمنيه \n• تم ترقية المالك ", true)
end
end
if Text and Text:match('(%d+)/LockAllGroup@(.*)') then
local UserId = {Text:match('(%d+)/LockAllGroup@(.*)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
redis:set(Jack.."Jack:Lock:tagservrbot"..UserId[2],true)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
redis:set(Jack..'Jack:'..lock..UserId[2],"del")    
end
LuaTele.answerCallbackQuery(data.id, "• تم قفل جميع الاوامر بنجاح  ", true)
end
end
if Text and Text:match('/leftgroup@(.*)') then
local UserId = Text:match('/leftgroup@(.*)')
LuaTele.answerCallbackQuery(data.id, "• تم مغادره البوت من المجموعه", true)
LuaTele.leaveChat(UserId)
end


if Text and Text:match('(%d+)/groupNumseteng//(%d+)') then
local UserId = {Text:match('(%d+)/groupNumseteng//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
return GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id)
end
end
if Text and Text:match('(%d+)/groupNum1//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum1//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).change_info) == 1 then
LuaTele.answerCallbackQuery(data.id, "• تم تعطيل صلاحيه تغيير المعلومات", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,'〖  لا 〗',nil,nil,nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,0, 0, 0, 0,0,0,1,0})
else
LuaTele.answerCallbackQuery(data.id, "• تم تفعيل صلاحيه تغيير المعلومات", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,'〖  نعم 〗',nil,nil,nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,1, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum2//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum2//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).pin_messages) == 1 then
LuaTele.answerCallbackQuery(data.id, "• تم تعطيل صلاحيه التثبيت", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,'〖  لا 〗',nil,nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,0, GetAdminsNum(ChatId,UserId[2]).promote})
else
LuaTele.answerCallbackQuery(data.id, "• تم تفعيل صلاحيه التثبيت", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,'〖  نعم 〗',nil,nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,1, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum3//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum3//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).restrict_members) == 1 then
LuaTele.answerCallbackQuery(data.id, "• تم تعطيل صلاحيه الحظر", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,'〖  لا 〗',nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, 0 ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
else
LuaTele.answerCallbackQuery(data.id, "• تم تفعيل صلاحيه الحظر", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,'〖  نعم 〗',nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, 1 ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum4//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum4//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).invite_users) == 1 then
LuaTele.answerCallbackQuery(data.id, "• تم تعطيل صلاحيه دعوه المستخدمين", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,'〖  لا 〗',nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, 0, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
else
LuaTele.answerCallbackQuery(data.id, "• تم تفعيل صلاحيه دعوه المستخدمين", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,'〖  نعم 〗',nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, 1, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum5//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum5//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).delete_messages) == 1 then
LuaTele.answerCallbackQuery(data.id, "• تم تعطيل صلاحيه مسح الرسائل", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,nil,'〖  لا 〗',nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, 0, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
else
LuaTele.answerCallbackQuery(data.id, "• تم تفعيل صلاحيه مسح الرسائل", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,nil,'〖  نعم 〗',nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, 1, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum6//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum6//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).promote) == 1 then
LuaTele.answerCallbackQuery(data.id, "• تم تعطيل صلاحيه اضافه مشرفين", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,nil,nil,'〖  لا 〗')
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, 0})
else
LuaTele.answerCallbackQuery(data.id, "• تم تفعيل صلاحيه اضافه مشرفين", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,nil,nil,'〖  نعم 〗')
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, 1})
end
end
end

if Text and Text:match('(%d+)/web') then
local UserId = Text:match('(%d+)/web')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).web == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, false, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, true, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/info') then
local UserId = Text:match('(%d+)/info')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).info == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, false, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, true, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/invite') then
local UserId = Text:match('(%d+)/invite')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).invite == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, false, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, true, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/pin') then
local UserId = Text:match('(%d+)/pin')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).pin == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, false)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, true)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/media') then
local UserId = Text:match('(%d+)/media')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).media == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, false, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, true, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/messges') then
local UserId = Text:match('(%d+)/messges')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).messges == true then
LuaTele.setChatPermissions(ChatId, false, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, true, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/other') then
local UserId = Text:match('(%d+)/other')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).other == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, false, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, true, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/polls') then
local UserId = Text:match('(%d+)/polls')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).polls == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, false, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, true, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
end
if Text and Text:match('(%d+)/listallAddorrem') then
local UserId = Text:match('(%d+)/listallAddorrem')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تعطيل الرابط', data = IdUser..'/'.. 'unmute_link'},{text = 'تفعيل الرابط', data = IdUser..'/'.. 'mute_link'},
},
{
{text = 'تعطيل الترحيب', data = IdUser..'/'.. 'unmute_welcome'},{text = 'تفعيل الترحيب', data = IdUser..'/'.. 'mute_welcome'},
},
{
{text = 'اتعطيل الايدي', data = IdUser..'/'.. 'unmute_Id'},{text = 'اتفعيل الايدي', data = IdUser..'/'.. 'mute_Id'},
},
{
{text = 'تعطيل الايدي بالصوره', data = IdUser..'/'.. 'unmute_IdPhoto'},{text = 'تفعيل الايدي بالصوره', data = IdUser..'/'.. 'mute_IdPhoto'},
},
{
{text = 'تعطيل ردود المدير', data = IdUser..'/'.. 'unmute_ryple'},{text = 'تفعيل ردود المدير', data = IdUser..'/'.. 'mute_ryple'},
},
{
{text = 'تعطيل ردود المطور', data = IdUser..'/'.. 'unmute_ryplesudo'},{text = 'تفعيل ردود المطور', data = IdUser..'/'.. 'mute_ryplesudo'},
},
{
{text = 'تعطيل الرفع', data = IdUser..'/'.. 'unmute_setadmib'},{text = 'تفعيل الرفع', data = IdUser..'/'.. 'mute_setadmib'},
},
{
{text = 'تعطيل الطرد', data = IdUser..'/'.. 'unmute_kickmembars'},{text = 'تفعيل الطرد', data = IdUser..'/'.. 'mute_kickmembars'},
},
{
{text = 'تعطيل الالعاب', data = IdUser..'/'.. 'unmute_games'},{text = 'تفعيل الالعاب', data = IdUser..'/'.. 'mute_games'},
},
{
{text = 'تعطيل اطردني', data = IdUser..'/'.. 'unmute_kickme'},{text = 'تفعيل اطردني', data = IdUser..'/'.. 'mute_kickme'},
},
{
{text = '{ القائمه الرئيسيه }', data = IdUser..'/helpall'},
},
{
{text = '- اخفاء الامر ', data =IdUser..'/'.. 'delAmr'}
},
}
}
return LuaTele.editMessageText(ChatId,Msg_id,'• اوامر التفعيل والتعطيل ', "md", false, false, reply_markup)
end
end
if Text and Text:match('(%d+)/NextSeting') then
local UserId = Text:match('(%d+)/NextSeting')
if tonumber(IdUser) == tonumber(UserId) then
local Text = "\n• اعدادات المجموعه ".."\n• علامة ال (نعم) تعني مقفول".."\n🔓︙علامة ال (لا) تعني مفتوح*"
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = GetSetieng(ChatId).lock_fwd, data = '&'},{text = 'التوجبه : ', data =IdUser..'/'.. 'Status_fwd'},
},
{
{text = GetSetieng(ChatId).lock_muse, data = '&'},{text = 'الصوت : ', data =IdUser..'/'.. 'Status_audio'},
},
{
{text = GetSetieng(ChatId).lock_ste, data = '&'},{text = 'الملصقات : ', data =IdUser..'/'.. 'Status_stikear'},
},
{
{text = GetSetieng(ChatId).lock_phon, data = '&'},{text = 'الجهات : ', data =IdUser..'/'.. 'Status_phone'},
},
{
{text = GetSetieng(ChatId).lock_join, data = '&'},{text = 'الدخول : ', data =IdUser..'/'.. 'Status_joine'},
},
{
{text = GetSetieng(ChatId).lock_add, data = '&'},{text = 'الاضافه : ', data =IdUser..'/'.. 'Status_addmem'},
},
{
{text = GetSetieng(ChatId).lock_self, data = '&'},{text = 'بصمه فيديو : ', data =IdUser..'/'.. 'Status_videonote'},
},
{
{text = GetSetieng(ChatId).lock_pin, data = '&'},{text = 'التثبيت : ', data =IdUser..'/'.. 'Status_pin'},
},
{
{text = GetSetieng(ChatId).lock_tagservr, data = '&'},{text = 'الاشعارات : ', data =IdUser..'/'.. 'Status_tgservir'},
},
{
{text = GetSetieng(ChatId).lock_mark, data = '&'},{text = 'الماركدون : ', data =IdUser..'/'.. 'Status_markdaun'},
},
{
{text = GetSetieng(ChatId).lock_edit, data = '&'},{text = 'التعديل : ', data =IdUser..'/'.. 'Status_edits'},
},
{
{text = GetSetieng(ChatId).lock_geam, data = '&'},{text = 'الالعاب : ', data =IdUser..'/'.. 'Status_games'},
},
{
{text = GetSetieng(ChatId).flood, data = '&'},{text = 'التكرار : ', data =IdUser..'/'.. 'Status_flood'},
},
{
{text = '- الرجوع ... ', data =IdUser..'/'.. 'NoNextSeting'}
},
{
{text = '{ القائمه الرئيسيه }', data = IdUser..'/helpall'},
},
{
{text = '- اخفاء الامر ', data =IdUser..'/'.. 'delAmr'}
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,Text, "md", false, false, reply_markup)
end
end
if Text and Text:match('(%d+)/NoNextSeting') then
local UserId = Text:match('(%d+)/NoNextSeting')
if tonumber(IdUser) == tonumber(UserId) then
local Text = "\n• اعدادات المجموعه ".."\n• علامة ال (نعم) تعني مقفول".."\n• علامة ال (لا) تعني مفتوح*"
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = GetSetieng(ChatId).lock_links, data = '&'},{text = 'الروابط : ', data =IdUser..'/'.. 'Status_link'},
},
{
{text = GetSetieng(ChatId).lock_spam, data = '&'},{text = 'الكلايش : ', data =IdUser..'/'.. 'Status_spam'},
},
{
{text = GetSetieng(ChatId).lock_inlin, data = '&'},{text = 'الكيبورد : ', data =IdUser..'/'.. 'Status_keypord'},
},
{
{text = GetSetieng(ChatId).lock_vico, data = '&'},{text = 'الاغاني : ', data =IdUser..'/'.. 'Status_voice'},
},
{
{text = GetSetieng(ChatId).lock_gif, data = '&'},{text = 'المتحركه : ', data =IdUser..'/'.. 'Status_gif'},
},
{
{text = GetSetieng(ChatId).lock_file, data = '&'},{text = 'الملفات : ', data =IdUser..'/'.. 'Status_files'},
},
{
{text = GetSetieng(ChatId).lock_text, data = '&'},{text = 'الدردشه : ', data =IdUser..'/'.. 'Status_text'},
},
{
{text = GetSetieng(ChatId).lock_ved, data = '&'},{text = 'الفيديو : ', data =IdUser..'/'.. 'Status_video'},
},
{
{text = GetSetieng(ChatId).lock_photo, data = '&'},{text = 'الصور : ', data =IdUser..'/'.. 'Status_photo'},
},
{
{text = GetSetieng(ChatId).lock_user, data = '&'},{text = 'المعرفات : ', data =IdUser..'/'.. 'Status_username'},
},
{
{text = GetSetieng(ChatId).lock_hash, data = '&'},{text = 'التاك : ', data =IdUser..'/'.. 'Status_tags'},
},
{
{text = GetSetieng(ChatId).lock_bots, data = '&'},{text = 'البوتات : ', data =IdUser..'/'.. 'Status_bots'},
},
{
{text = '- التالي ... ', data =IdUser..'/'.. 'NextSeting'}
},
{
{text = '{ القائمه الرئيسيه }', data = IdUser..'/helpall'},
},
{
{text = '- اخفاء الامر ', data =IdUser..'/'.. 'delAmr'}
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,Text, "md", false, false, reply_markup)
end
end 
if Text and Text:match('(%d+)/delAmr') then
local UserId = Text:match('(%d+)/delAmr')
if tonumber(IdUser) == tonumber(UserId) then
return LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
end
end
if Text and Text:match('(%d+)/Status_link') then
local UserId = Text:match('(%d+)/Status_link')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الروابط', data =UserId..'/'.. 'lock_link'},{text = 'قفل الروابط بالكتم', data =UserId..'/'.. 'lock_linkktm'},
},
{
{text = 'قفل الروابط بالطرد', data =UserId..'/'.. 'lock_linkkick'},{text = 'قفل الروابط بالتقييد', data =UserId..'/'.. 'lock_linkkid'},
},
{
{text = 'فتح الروابط', data =UserId..'/'.. 'unlock_link'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الروابط", "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_spam') then
local UserId = Text:match('(%d+)/Status_spam')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الكلايش', data =UserId..'/'.. 'lock_spam'},{text = 'قفل الكلايش بالكتم', data =UserId..'/'.. 'lock_spamktm'},
},
{
{text = 'قفل الكلايش بالطرد', data =UserId..'/'.. 'lock_spamkick'},{text = 'قفل الكلايش بالتقييد', data =UserId..'/'.. 'lock_spamid'},
},
{
{text = 'فتح الكلايش', data =UserId..'/'.. 'unlock_spam'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الكلايش", "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_keypord') then
local UserId = Text:match('(%d+)/Status_keypord')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الكيبورد', data =UserId..'/'.. 'lock_keypord'},{text = 'قفل الكيبورد بالكتم', data =UserId..'/'.. 'lock_keypordktm'},
},
{
{text = 'قفل الكيبورد بالطرد', data =UserId..'/'.. 'lock_keypordkick'},{text = 'قفل الكيبورد بالتقييد', data =UserId..'/'.. 'lock_keypordkid'},
},
{
{text = 'فتح الكيبورد', data =UserId..'/'.. 'unlock_keypord'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الكيبورد", "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_voice') then
local UserId = Text:match('(%d+)/Status_voice')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الاغاني', data =UserId..'/'.. 'lock_voice'},{text = 'قفل الاغاني بالكتم', data =UserId..'/'.. 'lock_voicektm'},
},
{
{text = 'قفل الاغاني بالطرد', data =UserId..'/'.. 'lock_voicekick'},{text = 'قفل الاغاني بالتقييد', data =UserId..'/'.. 'lock_voicekid'},
},
{
{text = 'فتح الاغاني', data =UserId..'/'.. 'unlock_voice'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الاغاني", "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_gif') then
local UserId = Text:match('(%d+)/Status_gif')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل المتحركه', data =UserId..'/'.. 'lock_gif'},{text = 'قفل المتحركه بالكتم', data =UserId..'/'.. 'lock_gifktm'},
},
{
{text = 'قفل المتحركه بالطرد', data =UserId..'/'.. 'lock_gifkick'},{text = 'قفل المتحركه بالتقييد', data =UserId..'/'.. 'lock_gifkid'},
},
{
{text = 'فتح المتحركه', data =UserId..'/'.. 'unlock_gif'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر المتحركات", "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_files') then
local UserId = Text:match('(%d+)/Status_files')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الملفات', data =UserId..'/'.. 'lock_files'},{text = 'قفل الملفات بالكتم', data =UserId..'/'.. 'lock_filesktm'},
},
{
{text = 'قفل النلفات بالطرد', data =UserId..'/'.. 'lock_fileskick'},{text = 'قفل الملقات بالتقييد', data =UserId..'/'.. 'lock_fileskid'},
},
{
{text = 'فتح الملقات', data =UserId..'/'.. 'unlock_files'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الملفات", "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_text') then
local UserId = Text:match('(%d+)/Status_text')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الدردشه', data =UserId..'/'.. 'lock_text'},
},
{
{text = 'فتح الدردشه', data =UserId..'/'.. 'unlock_text'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الدردشه", "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_video') then
local UserId = Text:match('(%d+)/Status_video')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الفيديو', data =UserId..'/'.. 'lock_video'},{text = 'قفل الفيديو بالكتم', data =UserId..'/'.. 'lock_videoktm'},
},
{
{text = 'قفل الفيديو بالطرد', data =UserId..'/'.. 'lock_videokick'},{text = 'قفل الفيديو بالتقييد', data =UserId..'/'.. 'lock_videokid'},
},
{
{text = 'فتح الفيديو', data =UserId..'/'.. 'unlock_video'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الفيديو", "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_photo') then
local UserId = Text:match('(%d+)/Status_photo')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الصور', data =UserId..'/'.. 'lock_photo'},{text = 'قفل الصور بالكتم', data =UserId..'/'.. 'lock_photoktm'},
},
{
{text = 'قفل الصور بالطرد', data =UserId..'/'.. 'lock_photokick'},{text = 'قفل الصور بالتقييد', data =UserId..'/'.. 'lock_photokid'},
},
{
{text = 'فتح الصور', data =UserId..'/'.. 'unlock_photo'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الصور", "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_username') then
local UserId = Text:match('(%d+)/Status_username')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل المعرفات', data =UserId..'/'.. 'lock_username'},{text = 'قفل المعرفات بالكتم', data =UserId..'/'.. 'lock_usernamektm'},
},
{
{text = 'قفل المعرفات بالطرد', data =UserId..'/'.. 'lock_usernamekick'},{text = 'قفل المعرفات بالتقييد', data =UserId..'/'.. 'lock_usernamekid'},
},
{
{text = 'فتح المعرفات', data =UserId..'/'.. 'unlock_username'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر المعرفات", "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_tags') then
local UserId = Text:match('(%d+)/Status_tags')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التاك', data =UserId..'/'.. 'lock_tags'},{text = 'قفل التاك بالكتم', data =UserId..'/'.. 'lock_tagsktm'},
},
{
{text = 'قفل التاك بالطرد', data =UserId..'/'.. 'lock_tagskick'},{text = 'قفل التاك بالتقييد', data =UserId..'/'.. 'lock_tagskid'},
},
{
{text = 'فتح التاك', data =UserId..'/'.. 'unlock_tags'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر التاك", "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_bots') then
local UserId = Text:match('(%d+)/Status_bots')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل البوتات', data =UserId..'/'.. 'lock_bots'},{text = 'قفل البوتات بالطرد', data =UserId..'/'.. 'lock_botskick'},
},
{
{text = 'فتح البوتات', data =UserId..'/'.. 'unlock_bots'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر البوتات", "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_fwd') then
local UserId = Text:match('(%d+)/Status_fwd')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التوجيه', data =UserId..'/'.. 'lock_fwd'},{text = 'قفل التوجيه بالكتم', data =UserId..'/'.. 'lock_fwdktm'},
},
{
{text = 'قفل التوجيه بالطرد', data =UserId..'/'.. 'lock_fwdkick'},{text = 'قفل التوجيه بالتقييد', data =UserId..'/'.. 'lock_fwdkid'},
},
{
{text = 'فتح التوجيه', data =UserId..'/'.. 'unlock_link'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر التوجيه", "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_audio') then
local UserId = Text:match('(%d+)/Status_audio')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الصوت', data =UserId..'/'.. 'lock_audio'},{text = 'قفل الصوت بالكتم', data =UserId..'/'.. 'lock_audioktm'},
},
{
{text = 'قفل الصوت بالطرد', data =UserId..'/'.. 'lock_audiokick'},{text = 'قفل الصوت بالتقييد', data =UserId..'/'.. 'lock_audiokid'},
},
{
{text = 'فتح الصوت', data =UserId..'/'.. 'unlock_audio'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الصوت", "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_stikear') then
local UserId = Text:match('(%d+)/Status_stikear')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الملصقات', data =UserId..'/'.. 'lock_stikear'},{text = 'قفل الملصقات بالكتم', data =UserId..'/'.. 'lock_stikearktm'},
},
{
{text = 'قفل الملصقات بالطرد', data =UserId..'/'.. 'lock_stikearkick'},{text = 'قفل الملصقات بالتقييد', data =UserId..'/'.. 'lock_stikearkid'},
},
{
{text = 'فتح الملصقات', data =UserId..'/'.. 'unlock_stikear'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الملصقات", "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_phone') then
local UserId = Text:match('(%d+)/Status_phone')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الجهات', data =UserId..'/'.. 'lock_phone'},{text = 'قفل الجهات بالكتم', data =UserId..'/'.. 'lock_phonektm'},
},
{
{text = 'قفل الجهات بالطرد', data =UserId..'/'.. 'lock_phonekick'},{text = 'قفل الجهات بالتقييد', data =UserId..'/'.. 'lock_phonekid'},
},
{
{text = 'فتح الجهات', data =UserId..'/'.. 'unlock_phone'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الجهات", "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_joine') then
local UserId = Text:match('(%d+)/Status_joine')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الدخول', data =UserId..'/'.. 'lock_joine'},
},
{
{text = 'فتح الدخول', data =UserId..'/'.. 'unlock_joine'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الدخول", "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_addmem') then
local UserId = Text:match('(%d+)/Status_addmem')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الاضافه', data =UserId..'/'.. 'lock_addmem'},
},
{
{text = 'فتح الاضافه', data =UserId..'/'.. 'unlock_addmem'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الاضافه", "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_videonote') then
local UserId = Text:match('(%d+)/Status_videonote')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل السيلفي', data =UserId..'/'.. 'lock_videonote'},{text = 'قفل السيلفي بالكتم', data =UserId..'/'.. 'lock_videonotektm'},
},
{
{text = 'قفل السيلفي بالطرد', data =UserId..'/'.. 'lock_videonotekick'},{text = 'قفل السيلفي بالتقييد', data =UserId..'/'.. 'lock_videonotekid'},
},
{
{text = 'فتح السيلفي', data =UserId..'/'.. 'unlock_videonote'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر بصمه الفيديو", "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_pin') then
local UserId = Text:match('(%d+)/Status_pin')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التثبيت', data =UserId..'/'.. 'lock_pin'},
},
{
{text = 'فتح التثبيت', data =UserId..'/'.. 'unlock_pin'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر التثبيت", "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_tgservir') then
local UserId = Text:match('(%d+)/Status_tgservir')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الاشعارات', data =UserId..'/'.. 'lock_tgservir'},
},
{
{text = 'فتح الاشعارات', data =UserId..'/'.. 'unlock_tgservir'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الاشعارات", "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_markdaun') then
local UserId = Text:match('(%d+)/Status_markdaun')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الماركداون', data =UserId..'/'.. 'lock_markdaun'},{text = 'قفل الماركداون بالكتم', data =UserId..'/'.. 'lock_markdaunktm'},
},
{
{text = 'قفل الماركداون بالطرد', data =UserId..'/'.. 'lock_markdaunkick'},{text = 'قفل الماركداون بالتقييد', data =UserId..'/'.. 'lock_markdaunkid'},
},
{
{text = 'فتح الماركداون', data =UserId..'/'.. 'unlock_markdaun'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الماركدون", "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_edits') then
local UserId = Text:match('(%d+)/Status_edits')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التعديل', data =UserId..'/'.. 'lock_edits'},
},
{
{text = 'فتح التعديل', data =UserId..'/'.. 'unlock_edits'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر التعديل", "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_games') then
local UserId = Text:match('(%d+)/Status_games')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الالعاب', data =UserId..'/'.. 'lock_games'},{text = 'قفل الالعاب بالكتم', data =UserId..'/'.. 'lock_gamesktm'},
},
{
{text = 'قفل الالعاب بالطرد', data =UserId..'/'.. 'lock_gameskick'},{text = 'قفل الالعاب بالتقييد', data =UserId..'/'.. 'lock_gameskid'},
},
{
{text = 'فتح الالعاب', data =UserId..'/'.. 'unlock_games'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر الالعاب", "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_flood') then
local UserId = Text:match('(%d+)/Status_flood')
if tonumber(IdUser) == tonumber(UserId) then

local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التكرار', data =UserId..'/'.. 'lock_flood'},{text = 'قفل التكرار بالكتم', data =UserId..'/'.. 'lock_floodktm'},
},
{
{text = 'قفل التكرار بالطرد', data =UserId..'/'.. 'lock_floodkick'},{text = 'قفل التكرار بالتقييد', data =UserId..'/'.. 'lock_floodkid'},
},
{
{text = 'فتح التكرار', data =UserId..'/'.. 'unlock_flood'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
LuaTele.editMessageText(ChatId,Msg_id,"• عليك اختيار نوع القفل او الفتح على امر التكرار", "md", true, false, reply_markup)
end



elseif Text and Text:match('(%d+)/unlock_link') then
local UserId = Text:match('(%d+)/unlock_link')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Lock:Link"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الروابط").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_spam') then
local UserId = Text:match('(%d+)/unlock_spam')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Lock:Spam"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الكلايش").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_keypord') then
local UserId = Text:match('(%d+)/unlock_keypord')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Lock:Keyboard"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الكيبورد").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_voice') then
local UserId = Text:match('(%d+)/unlock_voice')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Lock:vico"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الاغاني").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_gif') then
local UserId = Text:match('(%d+)/unlock_gif')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Lock:Animation"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح المتحركات").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_files') then
local UserId = Text:match('(%d+)/unlock_files')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Lock:Document"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الملفات").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_text') then
local UserId = Text:match('(%d+)/unlock_text')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Lock:text"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الدردشه").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_video') then
local UserId = Text:match('(%d+)/unlock_video')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Lock:Video"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الفيديو").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_photo') then
local UserId = Text:match('(%d+)/unlock_photo')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Lock:Photo"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الصور").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_username') then
local UserId = Text:match('(%d+)/unlock_username')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Lock:User:Name"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح المعرفات").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_tags') then
local UserId = Text:match('(%d+)/unlock_tags')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Lock:hashtak"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح التاك").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_bots') then
local UserId = Text:match('(%d+)/unlock_bots')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Lock:Bot:kick"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح البوتات").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_fwd') then
local UserId = Text:match('(%d+)/unlock_fwd')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Lock:forward"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح التوجيه").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_audio') then
local UserId = Text:match('(%d+)/unlock_audio')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Lock:Audio"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الصوت").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_stikear') then
local UserId = Text:match('(%d+)/unlock_stikear')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Lock:Sticker"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الملصقات").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_phone') then
local UserId = Text:match('(%d+)/unlock_phone')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Lock:Contact"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الجهات").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_joine') then
local UserId = Text:match('(%d+)/unlock_joine')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Lock:Join"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الدخول").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_addmem') then
local UserId = Text:match('(%d+)/unlock_addmem')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Lock:AddMempar"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الاضافه").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_videonote') then
local UserId = Text:match('(%d+)/unlock_videonote')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Lock:Unsupported"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح بصمه الفيديو").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_pin') then
local UserId = Text:match('(%d+)/unlock_pin')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:lockpin"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح التثبيت").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_tgservir') then
local UserId = Text:match('(%d+)/unlock_tgservir')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Lock:tagservr"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الاشعارات").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_markdaun') then
local UserId = Text:match('(%d+)/unlock_markdaun')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Lock:Markdaun"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الماركدون").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_edits') then
local UserId = Text:match('(%d+)/unlock_edits')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Lock:edit"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح التعديل").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_games') then
local UserId = Text:match('(%d+)/unlock_games')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Lock:geam"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح الالعاب").unLock, "md", true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_flood') then
local UserId = Text:match('(%d+)/unlock_flood')
if tonumber(IdUser) == tonumber(UserId) then
redis:hdel(Jack.."Jack:Spam:Group:User"..ChatId ,"Spam:User")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,Reply_Status(IdUser,"• تم فتح التكرار").unLock, "md", true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/Developers') then
local UserId = Text:match('(%d+)/Developers')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Developers:Groups") 
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح مطورين البوت", "md", false)
end
elseif Text and Text:match('(%d+)/DevelopersQ') then
local UserId = Text:match('(%d+)/DevelopersQ')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:DevelopersQ:Groups") 
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح مطورين الثانوين من البوت", "md", false)
end
elseif Text and Text:match('(%d+)/TheBasics') then
local UserId = Text:match('(%d+)/TheBasics')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack..":MONSHA_Groupp:"..ChatId) 
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح المنشئين الاساسيين", "md", false)
end
elseif Text and Text:match('(%d+)/TheBasicsQ') then
local UserId = Text:match('(%d+)/TheBasicsQ')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack..":MONSHA_Group:"..ChatId) 
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح المالكين", "md", false)
end
elseif Text and Text:match('(%d+)/Originators') then
local UserId = Text:match('(%d+)/Originators')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Originators:Group"..ChatId) 
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح منشئين المجموعه", "md", false)
end
elseif Text and Text:match('(%d+)/Managers') then
local UserId = Text:match('(%d+)/Managers')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Managers:Group"..ChatId) 
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح المدراء", "md", false)
end
elseif Text and Text:match('(%d+)/Addictive') then
local UserId = Text:match('(%d+)/Addictive')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Addictive:Group"..ChatId) 
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح ادمنيه المجموعه", "md", false)
end
elseif Text and Text:match('(%d+)/DelDistinguished') then
local UserId = Text:match('(%d+)/DelDistinguished')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:Distinguished:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح المميزين", "md", false)
end
elseif Text and Text:match('(%d+)/BanAll') then
local UserId = Text:match('(%d+)/BanAll')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:BanAll:Groups") 
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح المحظورين عام", "md", false)
end
elseif Text and Text:match('(%d+)/ktmAll') then
local UserId = Text:match('(%d+)/ktmAll')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:ktmAll:Groups") 
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح المكتومين عام", "md", false)
end
elseif Text and Text:match('(%d+)/BanGroup') then
local UserId = Text:match('(%d+)/BanGroup')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:BanGroup:Group"..ChatId) 
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح المحظورين", "md", false)
end
elseif Text and Text:match('(%d+)/SilentGroupGroup') then
local UserId = Text:match('(%d+)/SilentGroupGroup')
if tonumber(IdUser) == tonumber(UserId) then
redis:del(Jack.."Jack:SilentGroup:Group"..ChatId) 
LuaTele.editMessageText(ChatId,Msg_id,"• تم مسح المكتومين", "md", false)
end
end

end
end

luatele.run(CallBackLua)
 





