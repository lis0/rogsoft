<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<meta HTTP-EQUIV="Expires" CONTENT="-1"/>
<link rel="shortcut icon" href="images/favicon.png"/>
<link rel="icon" href="images/favicon.png"/>
<title>软件中心 - 离线安装</title>
<link rel="stylesheet" type="text/css" href="index_style.css"/>
<link rel="stylesheet" type="text/css" href="form_style.css"/>
<link rel="stylesheet" type="text/css" href="/res/softcenter.css">
<script type="text/javascript" src="/js/jquery.js"></script>
<script>
    var db_softcenter_ = [];
    $.getJSON("/_api/softcenter_", function(resp) {
        db_softcenter_=resp.result[0];
        if(!db_softcenter_["softcenter_version"]) {
            db_softcenter_["softcenter_version"] = "0.0";
        }
    });
</script>
<script type="text/javascript" src="/state.js"></script>
<script type="text/javascript" src="/popup.js"></script>
<script type="text/javascript" src="/help.js"></script>
<script type="text/javascript" src="/validator.js"></script>
<script type="text/javascript" src="/general.js"></script>
<script type="text/javascript" src="/switcherplugin/jquery.iphone-switch.js"></script>
<!--<script type="text/javascript" src="/res/softcenter.js"></script>-->
<script language="JavaScript" type="text/javascript" src="/client_function.js"></script>
<script>
function init(menu_hook) {
	show_menu();
	get_log();
}

function E(e) {
	return (typeof(e) == 'string') ? document.getElementById(e) : e;
}

function onSubmitCtrl(o, s) {
	document.form.action_mode.value = s;
	showLoading(7);
	document.form.submit();
}

function reload_Soft_Center() {
	location.href = "/Main_Soft_center.asp";
}

function menu_hook() {
	tabtitle[tabtitle.length - 1] = new Array("", "软件中心", "离线安装");
	tablink[tablink.length - 1] = new Array("", "Module_Softcenter.asp", "Module_Softsetting.asp");
}

function upload_software() {
	var filename = $("#file").val();
	filename = filename.split('\\');
	filename = filename[filename.length - 1];
	var filelast = filename.split('.');
	filelast = filelast[filelast.length - 1];
	if (filelast != 'gz') {
		alert('插件压缩包格式不正确！');
		return false;
	}
	document.getElementById('file_info').style.display = "none";
	var formData = new FormData();
	formData.append(filename, $('#file')[0].files[0]);
	//changeButton(true);
	$.ajax({
		url: '/_upload',
		type: 'POST',
		cache: false,
		data: formData,
		processData: false,
		contentType: false,
		complete: function(res) {
			if (res.status == 200) {
				var moduleInfo = {
					"soft_name": filename,
				};
				document.getElementById('file_info').style.display = "block";
				install_now(moduleInfo);
			}
		}
	});
}

function install_now(moduleInfo) {
	var id = parseInt(Math.random() * 100000000);
	var postData = {
		"id": id,
		"method": "dummy_script.sh",
		"params": [],
		"fields": moduleInfo
	};
	$.ajax({
		type: "POST",
		url: "/_api/",
		data: JSON.stringify(postData),
		dataType: "json",
		success: function(response) {
			get_log(1);
		},
		error: function() {
			currState.installing = false;
		}
	});
}

function get_log(s) {
	var retArea = E("soft_log");
	$.ajax({
		url: '/_temp/soft_log.txt',
		type: 'GET',
		dataType: 'html',
		async: true,
		cache: false,
		success: function(response) {
			if (response.search("XU6J03M6") != -1) {
				retArea.value = response.replace("XU6J03M6", " ");
				retArea.scrollTop = retArea.scrollHeight;
				if (s) {
					setTimeout("window.location.reload()", 3000);
				}
				return true;
			}
			if (_responseLen == response.length) {
				noChange++;
			} else {
				noChange = 0;
			}
			if (noChange > 8000) {
				//tabSelect("app1");
				return false;
			} else {
				setTimeout("get_log(1);", 400); //100 is radical but smooth!
			}
			retArea.value = response;
			retArea.scrollTop = retArea.scrollHeight;
			_responseLen = response.length;
		},
		error: function(xhr, status, error) {
			if (s) {
				E("soft_log").value = "获取日志失败！";
			}
		}
	});
}

</script>
</head>
<body onload="init();">
	<div id="TopBanner"></div>
	<div id="Loading" class="popup_bg"></div>
	<iframe name="hidden_frame" id="hidden_frame" src="" width="0" height="0" frameborder="0"></iframe>
	<form method="POST" name="form" action="" target="hidden_frame">
	<input type="hidden" name="current_page" value="Main_Soft_setting.asp"/>
	<input type="hidden" name="next_page" value="Main_Soft_setting.asp"/>
	<input type="hidden" name="group_id" value=""/>
	<input type="hidden" name="modified" value="0"/>
	<input type="hidden" name="action_mode" value=""/>
	<input type="hidden" name="action_script" value=""/>
	<input type="hidden" name="action_wait" value=""/>
	<input type="hidden" name="first_time" value=""/>
	<input type="hidden" name="preferred_lang" id="preferred_lang" value="<% nvram_get("preferred_lang"); %>"/>
	<input type="hidden" name="SystemCmd" onkeydown="onSubmitCtrl(this, ' Refresh ')" value="adm_config.sh"/>
	<input type="hidden" name="firmver" value="<% nvram_get("firmver"); %>"/>
	<input type="hidden" id="soft_name" name="soft_name" value=""/>
	<table class="content" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td width="17">&nbsp;</td>
			<td valign="top" width="202">
				<div id="mainMenu"></div>
				<div id="subMenu"></div>
			</td>
			<td valign="top">
				<div id="tabMenu" class="submenuBlock"></div>
				<table width="98%" border="0" align="left" cellpadding="0" cellspacing="0">
					<tr>
						<td align="left" valign="top">
							<table width="760px" border="0" cellpadding="5" cellspacing="0" bordercolor="#6b8fa3" class="FormTitle" id="FormTitle">
								<tr>
									<td bgcolor="#4D595D" colspan="3" valign="top">
										<div>&nbsp;</div>
										<div style="float:left;" class="formfonttitle">软件中心，离线安装页面</div>
										<div style="float:right; width:15px; height:25px;margin-top:10px"><img id="return_btn" onclick="reload_Soft_Center();" align="right" style="cursor:pointer;position:absolute;margin-left:-30px;margin-top:-25px;" title="返回软件中心" src="/images/backprev.png" onMouseOver="this.src='/images/backprevclick.png'" onMouseOut="this.src='/images/backprev.png'"></img></div>
										<div style="margin-left:5px;margin-top:10px;margin-bottom:10px"><img src="/images/New_ui/export/line_export.png"></div>
										<div class="formfontdesc" style="padding-top:5px;margin-top:0px;float: left;" id="cmdDesc"></div>
										<div style="padding-top:5px;margin-top:0px;float: left;" id="NoteBox" >
											<li>通过本页面，你可以上传插件的离线安装包来安装插件,此功能需要在7.0及以上的固件才能使用; </li>
											<li>离线安装会自动解压tar.gz后缀的压缩包，识别压缩包一级目录下的install.sh文件并执行； </li>
										</div>
										<div class="formfontdesc" id="cmdDesc"></div>
										<table style="margin:10px 0px 0px 0px;" width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable" id="routing_table">
											<thead>
											<tr>
												<td colspan="2">软件中心 - 高级设置</td>
											</tr>
											</thead>
											<tr>
												<th><a class="hintstyle" href="javascript:void(0);" onclick="openssHint(24)">离线安装插件</a></th>
												<td>
													<input type="button" id="upload_btn" class="button_gen" onclick="upload_software();" value="上传并安装"/>
													<input style="color:#FFCC00;*color:#000;width: 200px;" id="file" type="file" name="file"/>
													<img id="loadingicon" style="margin-left:5px;margin-right:5px;display:none;" src="/images/InternetScan.gif">
													<span id="file_info" style="display:none;">完成</span>
												</td>
											</tr>
                                    	</table>
                                    	<div id="log_content" style="margin-top:10px;display: block;">
											<textarea cols="63" rows="15" wrap="off" readonly="readonly" id="soft_log" style="width:99%; font-family:'Courier New', Courier, mono; font-size:11px;background:#475A5F;color:#FFFFFF;"></textarea>
										</div>
										<div style="margin-left:5px;margin-top:10px;margin-bottom:10px"><img src="/images/New_ui/export/line_export.png"></div>
										<div class="KoolshareBottom">
											<br/>论坛技术支持： <a href="http://www.koolshare.cn" target="_blank"> <i><u>www.koolshare.cn</u></i> </a> <br/>
											后台技术支持： <i>Xiaobao</i> <br/>
											Shell, Web by： <i>Sadoneli</i><br/>
										</div>
									</td>
								</tr>
							</table>
						</td>
						<td width="10" align="center" valign="top"></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	</form>
	</td>
	<div id="footer"></div>
</body>
</html>



