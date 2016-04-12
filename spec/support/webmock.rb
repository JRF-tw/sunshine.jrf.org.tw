module Webmock
  def webmock_all!
    stub_request(:get, "https://google.com/api.json").
      to_return(:headers => { 'Content-Type' => 'application/json' }, :body => '{ "ok": true }')

    stub_request(:post, "http://csdi.judicial.gov.tw/abbs/wkw/WHD3A01.jsp").
         with(:body => {"court"=>"TPH"}).
      to_return(:headers => { 'Content-Type' => 'application/json' }, :body => '
      <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
      <!--
          程式名稱：案件庭期查詢系統       程式功能：案件庭期查詢
          程式設計：林志賢                 更新日期：
      -->
      <HTML><HEAD><TITLE>案件庭期查詢系統</TITLE>
      <META http-equiv=Content-Type content="text/html; charset=MS950">
      <META content="MSHTML 6.00.2900.2802" name=GENERATOR></HEAD>
      <style type="text/css">
      <!--
      @import "../css/NEW.css";
      -->
      </style>

        <script language="javascript">
        <!--

      function getDep()
      {
          selC = document.form.crtid;
          selS = document.form.sys;
          cIndexed = selC.options[selC.selectedIndex];

          if (cIndexed.value.substr(2,1).toUpperCase() == \'B\') selS[3].checked=true;
          if (cIndexed.value.substr(2,1).toUpperCase() == \'Y\') selS[2].checked=true;

        var sValue ='';
          //sValue = selS[0].checked?selS[0].value: selS[1].checked ? selS[1].value:selS[2].value ;
          if (selC.value==\'TPC\'){
            sValue = \'D\'; //職務法庭，系統別固定D
          }else{
            for(var i=0;i<selS.length;i++){
              if (selS[i].checked){
                sValue = selS[i].value;
                break;
              }
            }
          }

          if (-1 == navigator.userAgent.indexOf("MSIE"))
              p = "WHD3A03.jsp?court="+escape(cIndexed.value)+"&sys="+escape(sValue);
          else
              p = "WHD3A03.jsp?court="+cIndexed.value+"&sys="+sValue;
          nw = window.open(p, "", "toolbar=no,menubar=no,left=180,top=210,width=400,height=200")
      }


      function showAffair()
      {
          selC = document.form.crtid;
          selS = document.form.sys;
          cIndexed = selC.options[selC.selectedIndex]

          if (selC.selectedIndex > 0)
             alert("「法院名稱」請選擇該簡易庭(少年庭)所屬之法院!!");
          else
          {
           if (-1 == navigator.userAgent.indexOf("MSIE"))
               p = "WHD3A04.jsp?court="+escape(cIndexed.value).substring(0,3);
           else
               p = "WHD3A04.jsp?court="+cIndexed.value.substring(0,3);
           window.location.href = p;
          }
      }

      function downloadAffair()
      {
          selC = document.form.crtid;
          selS = document.form.sys;
          cIndexed = selC.options[selC.selectedIndex]

          if (selC.selectedIndex > 0)
             alert("「法院名稱」請選擇該簡易庭(少年庭)所屬之法院!!");
          else
          {
           if (-1 == navigator.userAgent.indexOf("MSIE"))
               p = "WHD3A01_DOWNLOADCVS.jsp?court="+escape(cIndexed.value).substring(0,3);
           else
               p = "WHD3A01_DOWNLOADCVS.jsp?court="+cIndexed.value.substring(0,3);

           window.location.href = p;
          }
      }


      function final1()
      {
           if(document.getElementById(\'date1\').value!="")
              if(!chkDate(document.getElementById(\'date1\')))
              {
                 alert(\'開庭日期格式錯誤\');
                 return false;
              }

           if(document.getElementById(\'date2\').value!="")
              if(!chkDate(document.getElementById(\'date2\')))
              {
                 alert(\'開庭日期格式錯誤\');
                 return false;
              }

           if(document.getElementById(\'date1\')!=""&&document.getElementById(\'date2\')!="")
              if(document.getElementById(\'date1\').value>document.getElementById(\'date2\').value)
              {
                 alert(\'開庭日啟始日大於結束日\');
                 return false;
              }
           document.form.submit();
           //return true;
      }
      //???d?O§_?°???T?????A6?X?e?±·|?[0?A???\???J?t??(???e)
      function chkDate(obj){
        if (obj.value.charAt(0)=="-")
        {
          if (obj.value.length==7)
            var instring=obj.value;
          else
            return false;
        }
        else
        {
          if (obj.value.length==6)
          {
            obj.value="0"+obj.value;
            var instring=obj.value;
          }
          else
            var instring=obj.value;
        }
        var year=parseFloat(instring.substring(0,3))+1911;
        var month=parseFloat(instring.substring(3,5))-1;
        var day=parseFloat(instring.substring(5,7));
        var indate=new Date(year,month,day);
        if (!(indate.getMonth()==parseFloat(instring.substring(3,5))-1))
           return false;

        return true;
      }
      function fOnSubmit()
      {

          //tpF = document.judForm;
          //selC = document.judForm.v_court;
          //selS = document.judForm.v_sys;
          tpF = document.getElementById(\'judForm\');
          selC = document.getElementById(\'v_court\');
          selS = document.getElementById(\'v_sys\');
          cIndexed = selC.options[selC.selectedIndex];

          d = tpF.jud_dep.value == "";
          y = tpF.jud_year.value == "";
          w = tpF.jud_word.value == "";
          c = tpF.jud_case.value == "";
          dt1 = tpF.jud_date1.value == "";
          dt2 = tpF.jud_date2.value == "";

          if (cIndexed.value.substr(2,1).toUpperCase() == \'Y\') selS[1].checked=true;
          if ((dt1 && !dt2 ) || (!dt1 && dt2))
          {
              alert("『開庭日期』輸入起迄日期不完整，不予受理！");
              return
          }
          if (d && y && w && c && dt1)
          {
              alert("請輸入「案件字號」或「股別」或「開庭日期」資料，否則不予受理！");
              return
          }
          lost = ((y == "") || (w == "") || (c == "")) && !((y=="") && (w =="") && (c==""))
          if (lost)
          {
            alert("『案件字號』輸入資料不完整，否則不予受理！");
            return
           }

          document.judForm.submit()

      }
      // --></script>
      <script language="javascript" src="../script/FORM.js"></script>
      <script language="javascript" src="../script/BRING.js"></script>
      <script language="javascript" src="../script/STRING.js"></script>
      <script language="javascript" src="../script/WINDOW.js"></script>
      <BODY leftMargin=0 topMargin=0 onload=""><BR>
      <form name="form" method="post" action="WHD3A02.jsp" onsubmit="return final1();">
      <TABLE cellSpacing=0 cellPadding=0 width=760 align=center border=0>
        <TBODY>
        <TR>
          <TD width=640 background="../image/title_03.gif" height=33>
            <TABLE cellSpacing=0 cellPadding=0 width=439 align=left border=0>
              <TBODY>
              <TR>
                <TD width=164>
                  <DIV align=right></DIV></TD>
                <TD noWrap width=275>
                  <DIV align=left><FONT
          size=2>請輸入查詢條件</FONT></DIV></TD></TR></TBODY></TABLE></TD></TR>
        <TR>
          <TD background="../image/fjudqry01table02.gif">
            <DIV align=center>
            <DIV align=center>
            <CENTER>
                    <TABLE class=big cellSpacing=0 cellPadding=4 width=95% border=0>
                      <TBODY>
                      <TR>
                        <TD vAlign=center align=right width="13%"><FONT
                size=2>法院名稱：</FONT></TD>
                        <TD colspan="4" align="left" vAlign=center>
                          <select name="crtid" id="crtid">

                            <option value="TPH">臺灣高等法院</option>

                          </select>
                        </TD>
                      </TR>
                      <TR>
                        <TD vAlign=bottom align=right width="13%"><font size="2">案件類別：</font></TD>
                        <TD colspan="2" align="left" vAlign=center>
                        <font size="2">


                          <input type="radio" name="sys" value="V"  checked>
                             民事
                          <input type="radio" name="sys" value="H" >
                             刑事
                          <input type="radio" name="sys" value="I" >
                             少年
                          <input type="radio" name="sys" value="A"  >
                            行政


                    </font>
                          </TD>
                        <TD width="13%" rowspan="2" align="left" vAlign=center><font color="red" size="1"><img src="../image/app_qrcode.png" border="0" title="下載Android版庭期表查詢" width="50" height="50"><br>
                          下載 Android 版<br>
                          庭期表查詢程式</font></TD>
                        <TD width="14%" rowspan="2" align="left" vAlign=center><font color="red" size="1"><img src="../image/iphone_qrcode.png" border="0" title="下載iphone版庭期表查詢" width="50" height="50"><br>
      下載 iphone 版<br>
      庭期表查詢程式</font></TD>
                      </TR>
                      <TR>
                        <TD vAlign=center align=right width="13%"><font size="2">案件字號：</font></TD>
                        <TD colspan="2" align="left" vAlign=center>
                          <font size="2"> <input name="crmyy" id="crmyy" type="text" size="3" maxlength="3"  onKeyPress="lockNum();" onBlur="addnum(this,3)" check="F10">
                            年
                            <input type="text" name="crmid" id="crmid" size="8">
                            字第
                            <input name="crmno" type="text" id="crmno" size="6" maxlength="6"  onKeyPress="lockNum();" onBlur="addnum(this,6)" check="F10">
                            號</font></TD>
                        </TR>
                      <TR>
                        <TD vAlign=center align=right width="13%"><font size="2">開庭日期：</font></TD>
                        <TD colspan="4" align="left" vAlign=center>
                          <font size="2"><input type="text" name="date1" id="date1" size="7" value="">
                          ～
                          <input type="text" name="date2" id="date2" size="7" value="">
                          (例民國101年1月15日應輸入"1010115")</font></TD>
      <!--          (0920112~0920212)</font></TD> -->
                      </TR>
                      <TR>
                        <TD vAlign=middle align=right width="13%"><font size="2">股別：</font></TD>
                        <TD width="32%" align="left" vAlign=center><strong>
                          <input type="text" name="dptcd" id="dptcd" size="8" maxlength="8">
                          <input type="button" value="選擇股別" style=" color: rgb(0,0,128); font-weight: bolder; font-size: 15; border: thin" onClick="getDep()" onKeyPress="getDep()" name="button">
                          </strong></TD>
                        <TD colspan="3" align="left" vAlign=center><table width="100%" border="0">
                          <tr>
                            <th width="55%" scope="col" align="right"><input type="button" alt="下載股別分配表csv檔" value="下載股別分配表csv檔" onClick="javascript:downloadAffair();" onKeyPress="javascript:showAffair();" name="button2"  style="width:150px;background-color:pink"></th>
                            <th width="45%" scope="col" align="left"><input type="button" alt="股別分配表" value="股別分配表" onClick="javascript:showAffair();" onKeyPress="javascript:showAffair();" name="button3" style="width:120px"></th>
                          </tr>
                          <tr>
                            <th scope="row" align="right"><FONT size=2>
                              <INPUT class=small type=submit value=　查　詢　 name=Button style="width:150px">
                            </FONT></th>
                            <td align="left"><FONT size=2>
                              <INPUT class=small type=reset value=　清　除　 name=reset style="width:120px">
                            </FONT></td>
                          </tr>
                        </table></TD>
                        </TR>
                      <TR>
                        <TD vAlign=top align=right colSpan=5><FONT size=2> </FONT>
                          <DIV align=center></DIV>
                        </TD>
                      </TR>
                      </TBODY>
                    </TABLE>
                  </CENTER></DIV>
            <DIV align=center>
            <CENTER></CENTER></DIV></DIV></TD></TR>
        <TR>
          <TD height=10><IMG height=10 src="../image/fjudqry01table03.gif"
            width=760></TD></TR></TBODY></TABLE></FORM>


      <DIV align=center>
      <CENTER>
      <TABLE cellPadding=1 width="100%" border=0>
        <TBODY>
        <TR>
          <TD>
            <DIV align=center>


      </DIV></TD></TR></TBODY></TABLE>
          <TABLE class=big cellSpacing=0 cellPadding=2 width=640 align=center border=0>
            <TBODY>
            <TR>
              <TD vAlign=top width=44 height=20><FONT size=2>說明 :</FONT></TD>
              <TD vAlign=top width=12 height=20><FONT size=2>1. </FONT></TD>
              <TD vAlign=top width=584 height=20 align="left"><FONT size=2>本庭期僅供參考，如有闕漏、不符者，以實際開庭通知單為準，若查無庭期，請逕向該管法院查詢。</font></TD>
            </TR>
            <TR>
              <TD vAlign=top height=20><FONT size=2>&nbsp;</FONT></TD>
              <TD vAlign=top height=20><FONT size=2>2.</FONT></TD>
              <TD vAlign=top height=20 align="left"><FONT size=2>本系統僅提供尚未開庭之庭期查詢，恕不提供已開庭期之查詢，尚
                祈見諒。</font></TD>
            </TR>
            <TR>
              <TD vAlign=top width=44 height=20><FONT size=2>&nbsp;</FONT></TD>
              <TD vAlign=top height=20><FONT size=2>3.</FONT></TD>
              <TD vAlign=top height=20 align="left"><FONT size="2" color="red">Android手機之庭期表查詢程式 需 Android 2.2(含)以上版本</font></TD>
            </TR>
            <TR>
            <TR>
              <TD vAlign=top width=44 height=20><FONT size=2>&nbsp;</FONT></TD>
              <TD vAlign=top height=20><FONT size=2>4.</FONT></TD>
              <TD vAlign=top height=20 align="left"><FONT size=2>對本系統若有任何疑議建言，歡迎來信指教。</font></TD>
            </TR>
            <TR>
              <TD vAlign=top colspan="3" height=20 align="center"><FONT size=2>&nbsp;</FONT>
                <font size=2>建議您使用800*600全彩及 <a href="http://www.microsoft.com/taiwan/products/ie/" target="_blank" title="下載IE">
                Explorer 5.5 </a> 版本以上瀏覽器&nbsp;</font> </TD>
            </TR>

            </TBODY>
          </TABLE>


      <TABLE height=33 cellSpacing=0 cellPadding=0 width=760 align=center border=0>
        <TBODY>
        <TR>
          <TD background="../image/welcome.gif">
            <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
              <TBODY>
              <TR>
                <TD width="12%">&nbsp;</TD>
                <TD width="75%">
                  <DIV align=center><FONT size=2><A href="http://www.judicial.gov.tw/"
                  target=_parent>司法院</A> 資訊管理處 製作。 對於本系統功能有任何建議，<A
                  href="http://www.judicial.gov.tw/email/write.htm" target=_blank>
                  歡迎來信</A></FONT>。</DIV></TD>
                <TD
      width="13%">&nbsp;</TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></CENTER></DIV>
      <P align=center><FONT face=標楷體><BR></FONT></P></BODY></HTML>
      ')

    stub_request(:get, /http:\/\/csdi\.judicial\.gov\.tw\/abbs\/wkw\/WHD3A02\.jsp/).
      to_return(:status => 200, :body => '
        <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
        <html>
        <head>
        <title>案件庭期查詢系統</title>
        <meta http-equiv="Content-Type" content="text/html; charset=MS950">
        <style type="text/css">
        <!--
        @import "../image/css.css";
        -->
        </style>
        </head>

        <body text="#000000" bgcolor="#FFFFFF"  >
        <form name="form">
        <table width="90%" border="0" align="center" cellspacing="0" cellpadding="0">
          <tr>
              <td width="1%">&nbsp;</td>
              <td width="98%">
                <div align="center"></div>
            </td>
              <td width="1%">&nbsp;</td>
          </tr>
          <tr>
              <td colspan="3">
                <div align="center"><strong><font face="標楷體" color="#000080" >臺灣高等法院</font></strong></div></td>
          </tr>
          <tr>
              <td width="1%">&nbsp;</td>
              <td bgcolor="#FFFFFF" width="98%"> <img alt="" src="../image/line.gif" width="1" height="1"></td>
              <td width="1%">&nbsp;</td>
          </tr>
          <tr>
              <td width="1%" bgcolor="#FFFFFF">&nbsp;</td>
              <td width="98%">
                <table width="100%" border="1" cellspacing="0"  cellpadding="0">
                  <tr>
                    <td width="7%" class="head">
                      <div align="center"> 筆數</div></td>
                    <td width="7%" class="head">
                      <div align="center">類別
                      </div></td>
                    <td class="head" width="7%">
                      <div align="center">年度</div></td>
                    <td class="head" width="14%">
                      <div align="center">字別</div></td>
                    <td class="head" width="9%">
                      <div align="center">案號</div></td>
                    <td class="head" width="11%">
                      <div align="center">開庭<br>
                        日期</div></td>
                    <td class="head" width="10%">
                      <div align="center">開庭<br>
                        時間</div></td>
                    <td class="head" width="17%">
                      <div align="center">法庭</div></td>
                    <td class="head" width="9%">股別</td>
                    <td class="head" width="9%">
                      <div align="center">庭類</div></td>
                  </tr>

                  <tr>
                    <td width="7%">
                      <div align="center">1</div></td>
                    <td width="7%">
                      <div align="center">民事</div></td>
                    <td width="7%">
                      <div align="center">105</div></td>
                    <td width="14%">抗</td>
                    <td width="9%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;485</td>
                    <td width="11%">105/04/11</td>
                    <td width="10%">
                      <div align="center">0900</div></td>
                    <td width="17%">
                      <div align="center">第十二法庭</div></td>
                    <td width="9%">孝</td>
                    <td width="9%">
                      訊問</td>
                  </tr>

                  <tr>
                    <td width="7%">
                      <div align="center">2</div></td>
                    <td width="7%">
                      <div align="center">民事</div></td>
                    <td width="7%">
                      <div align="center">104</div></td>
                    <td width="14%">重家上</td>
                    <td width="9%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;79</td>
                    <td width="11%">105/04/11</td>
                    <td width="10%">
                      <div align="center">0910</div></td>
                    <td width="17%">
                      <div align="center">第九法庭</div></td>
                    <td width="9%">洪</td>
                    <td width="9%">
                      準備程序</td>
                  </tr>

                  <tr>
                    <td width="7%">
                      <div align="center">3</div></td>
                    <td width="7%">
                      <div align="center">民事</div></td>
                    <td width="7%">
                      <div align="center">105</div></td>
                    <td width="14%">上</td>
                    <td width="9%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;238</td>
                    <td width="11%">105/04/11</td>
                    <td width="10%">
                      <div align="center">0920</div></td>
                    <td width="17%">
                      <div align="center">第十四法庭</div></td>
                    <td width="9%">和</td>
                    <td width="9%">
                      準備程序</td>
                  </tr>

                  <tr>
                    <td width="7%">
                      <div align="center">4</div></td>
                    <td width="7%">
                      <div align="center">民事</div></td>
                    <td width="7%">
                      <div align="center">105</div></td>
                    <td width="14%">上更㯲</td>
                    <td width="9%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;11</td>
                    <td width="11%">105/04/11</td>
                    <td width="10%">
                      <div align="center">0920</div></td>
                    <td width="17%">
                      <div align="center">第十六法庭</div></td>
                    <td width="9%">信</td>
                    <td width="9%">
                      準備程序</td>
                  </tr>

                  <tr>
                    <td width="7%">
                      <div align="center">5</div></td>
                    <td width="7%">
                      <div align="center">民事</div></td>
                    <td width="7%">
                      <div align="center">105</div></td>
                    <td width="14%">勞上更㯲</td>
                    <td width="9%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1</td>
                    <td width="11%">105/04/11</td>
                    <td width="10%">
                      <div align="center">0920</div></td>
                    <td width="17%">
                      <div align="center">第七法庭</div></td>
                    <td width="9%">團</td>
                    <td width="9%">
                      準備程序</td>
                  </tr>

                  <tr>
                    <td width="7%">
                      <div align="center">6</div></td>
                    <td width="7%">
                      <div align="center">民事</div></td>
                    <td width="7%">
                      <div align="center">101</div></td>
                    <td width="14%">上</td>
                    <td width="9%">&nbsp;&nbsp;&nbsp;&nbsp;1097</td>
                    <td width="11%">105/04/11</td>
                    <td width="10%">
                      <div align="center">0930</div></td>
                    <td width="17%">
                      <div align="center">第二調解室(B1F)</div></td>
                    <td width="9%">廉</td>
                    <td width="9%">
                      調解</td>
                  </tr>

                  <tr>
                    <td width="7%">
                      <div align="center">7</div></td>
                    <td width="7%">
                      <div align="center">民事</div></td>
                    <td width="7%">
                      <div align="center">103</div></td>
                    <td width="14%">上</td>
                    <td width="9%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;783</td>
                    <td width="11%">105/04/11</td>
                    <td width="10%">
                      <div align="center">0930</div></td>
                    <td width="17%">
                      <div align="center">第四法庭</div></td>
                    <td width="9%">晉</td>
                    <td width="9%">
                      準備程序</td>
                  </tr>

                  <tr>
                    <td width="7%">
                      <div align="center">8</div></td>
                    <td width="7%">
                      <div align="center">民事</div></td>
                    <td width="7%">
                      <div align="center">103</div></td>
                    <td width="14%">上</td>
                    <td width="9%">&nbsp;&nbsp;&nbsp;&nbsp;1198</td>
                    <td width="11%">105/04/11</td>
                    <td width="10%">
                      <div align="center">0930</div></td>
                    <td width="17%">
                      <div align="center">第二法庭</div></td>
                    <td width="9%">康</td>
                    <td width="9%">
                      準備程序</td>
                  </tr>

                  <tr>
                    <td width="7%">
                      <div align="center">9</div></td>
                    <td width="7%">
                      <div align="center">民事</div></td>
                    <td width="7%">
                      <div align="center">104</div></td>
                    <td width="14%">上</td>
                    <td width="9%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;780</td>
                    <td width="11%">105/04/11</td>
                    <td width="10%">
                      <div align="center">0930</div></td>
                    <td width="17%">
                      <div align="center">第十一法庭</div></td>
                    <td width="9%">正</td>
                    <td width="9%">
                      準備程序</td>
                  </tr>

                  <tr>
                    <td width="7%">
                      <div align="center">10</div></td>
                    <td width="7%">
                      <div align="center">民事</div></td>
                    <td width="7%">
                      <div align="center">104</div></td>
                    <td width="14%">上</td>
                    <td width="9%">&nbsp;&nbsp;&nbsp;&nbsp;1087</td>
                    <td width="11%">105/04/11</td>
                    <td width="10%">
                      <div align="center">0930</div></td>
                    <td width="17%">
                      <div align="center">第十二法庭</div></td>
                    <td width="9%">孝</td>
                    <td width="9%">
                      準備程序</td>
                  </tr>

                  <tr>
                    <td width="7%">
                      <div align="center">11</div></td>
                    <td width="7%">
                      <div align="center">民事</div></td>
                    <td width="7%">
                      <div align="center">104</div></td>
                    <td width="14%">上</td>
                    <td width="9%">&nbsp;&nbsp;&nbsp;&nbsp;1461</td>
                    <td width="11%">105/04/11</td>
                    <td width="10%">
                      <div align="center">0930</div></td>
                    <td width="17%">
                      <div align="center">協商室(2F)</div></td>
                    <td width="9%">情</td>
                    <td width="9%">
                      準備程序</td>
                  </tr>

                  <tr>
                    <td width="7%">
                      <div align="center">12</div></td>
                    <td width="7%">
                      <div align="center">民事</div></td>
                    <td width="7%">
                      <div align="center">104</div></td>
                    <td width="14%">重上</td>
                    <td width="9%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;154</td>
                    <td width="11%">105/04/11</td>
                    <td width="10%">
                      <div align="center">0930</div></td>
                    <td width="17%">
                      <div align="center">協商室(1F)</div></td>
                    <td width="9%">良</td>
                    <td width="9%">
                      調解</td>
                  </tr>

                  <tr>
                    <td width="7%">
                      <div align="center">13</div></td>
                    <td width="7%">
                      <div align="center">民事</div></td>
                    <td width="7%">
                      <div align="center">104</div></td>
                    <td width="14%">重上</td>
                    <td width="9%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;482</td>
                    <td width="11%">105/04/11</td>
                    <td width="10%">
                      <div align="center">0930</div></td>
                    <td width="17%">
                      <div align="center">第九法庭</div></td>
                    <td width="9%">洪</td>
                    <td width="9%">
                      準備程序</td>
                  </tr>

                  <tr>
                    <td width="7%">
                      <div align="center">14</div></td>
                    <td width="7%">
                      <div align="center">民事</div></td>
                    <td width="7%">
                      <div align="center">104</div></td>
                    <td width="14%">重上</td>
                    <td width="9%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;702</td>
                    <td width="11%">105/04/11</td>
                    <td width="10%">
                      <div align="center">0930</div></td>
                    <td width="17%">
                      <div align="center">第十三法庭</div></td>
                    <td width="9%">乙</td>
                    <td width="9%">
                      準備程序</td>
                  </tr>

                  <tr>
                    <td width="7%">
                      <div align="center">15</div></td>
                    <td width="7%">
                      <div align="center">民事</div></td>
                    <td width="7%">
                      <div align="center">104</div></td>
                    <td width="14%">重上</td>
                    <td width="9%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;785</td>
                    <td width="11%">105/04/11</td>
                    <td width="10%">
                      <div align="center">0930</div></td>
                    <td width="17%">
                      <div align="center">第十法庭</div></td>
                    <td width="9%">光</td>
                    <td width="9%">
                      準備程序</td>
                  </tr>

                </table></td>
              <td width="1%" bgcolor="#FFFFFF">&nbsp;</td>
          </tr>
          <tr>
              <td width="1%">&nbsp;</td>
              <td bgcolor="#FFFFFF" width="98%"><img alt="" src="../image/line.gif" width="1" height="1"></td>
              <td width="1%">&nbsp;</td>
          </tr>
          <table width=\'95%\' boder=\'0\' align=\'center\'>
        <tr><td>
        合計件數:&nbsp;168&nbsp;件&nbsp;&nbsp;
        </td></tr>
        <tr><td align=\'center\'>
        <<第一頁
        &nbsp;&nbsp;
        <nobr><<上10頁
        </nobr>&nbsp;&nbsp;
        <nobr><上一頁
        </nobr>&nbsp;&nbsp;
        <nobr>[1]
        </nobr>&nbsp;&nbsp;
        <nobr onmouseover="this.style.cursor=\'hand\'" onfocus="this.style.cursor=\'hand\'" onkeypress=\'form.pageNow.value=2;form.submit();\' onclick=\'form.pageNow.value=2;form.submit();\'><font color=\'#0000FF\'>2
        </font></nobr>&nbsp;&nbsp;
        <nobr onmouseover="this.style.cursor=\'hand\'" onfocus="this.style.cursor=\'hand\'" onkeypress=\'form.pageNow.value=3;form.submit();\' onclick=\'form.pageNow.value=3;form.submit();\'><font color=\'#0000FF\'>3
        </font></nobr>&nbsp;&nbsp;
        <nobr onmouseover="this.style.cursor=\'hand\'" onfocus="this.style.cursor=\'hand\'" onkeypress=\'form.pageNow.value=4;form.submit();\' onclick=\'form.pageNow.value=4;form.submit();\'><font color=\'#0000FF\'>4
        </font></nobr>&nbsp;&nbsp;
        <nobr onmouseover="this.style.cursor=\'hand\'" onfocus="this.style.cursor=\'hand\'" onkeypress=\'form.pageNow.value=5;form.submit();\' onclick=\'form.pageNow.value=5;form.submit();\'><font color=\'#0000FF\'>5
        </font></nobr>&nbsp;&nbsp;
        <nobr onmouseover="this.style.cursor=\'hand\'" onfocus="this.style.cursor=\'hand\'" onkeypress=\'form.pageNow.value=6;form.submit();\' onclick=\'form.pageNow.value=6;form.submit();\'><font color=\'#0000FF\'>6
        </font></nobr>&nbsp;&nbsp;
        <nobr onmouseover="this.style.cursor=\'hand\'" onfocus="this.style.cursor=\'hand\'" onkeypress=\'form.pageNow.value=7;form.submit();\' onclick=\'form.pageNow.value=7;form.submit();\'><font color=\'#0000FF\'>7
        </font></nobr>&nbsp;&nbsp;
        <nobr onmouseover="this.style.cursor=\'hand\'" onfocus="this.style.cursor=\'hand\'" onkeypress=\'form.pageNow.value=8;form.submit();\' onclick=\'form.pageNow.value=8;form.submit();\'><font color=\'#0000FF\'>8
        </font></nobr>&nbsp;&nbsp;
        <nobr onmouseover="this.style.cursor=\'hand\'" onfocus="this.style.cursor=\'hand\'" onkeypress=\'form.pageNow.value=9;form.submit();\' onclick=\'form.pageNow.value=9;form.submit();\'><font color=\'#0000FF\'>9
        </font></nobr>&nbsp;&nbsp;
        <nobr onmouseover="this.style.cursor=\'hand\'" onfocus="this.style.cursor=\'hand\'" onkeypress=\'form.pageNow.value=10;form.submit();\' onclick=\'form.pageNow.value=10;form.submit();\'><font color=\'#0000FF\'>10
        </font></nobr>&nbsp;&nbsp;
        <nobr onmouseover="this.style.cursor=\'hand\'" onfocus="this.style.cursor=\'hand\'" onclick=\'form.pageNow.value=2;form.submit();\' onkeypress=\'form.pageNow.value=2;form.submit();\'><font color=\'#0000FF\'>下一頁></font>
        </nobr>&nbsp;&nbsp;
        <nobr onmouseover="this.style.cursor=\'hand\'" onfocus="this.style.cursor=\'hand\'" onclick=\'form.pageNow.value=11;form.submit();\' onkeypress=\'form.pageNow.value=11;form.submit();\'><font color=\'#0000FF\'>下10頁>></font>
        </nobr>&nbsp;&nbsp;
        <nobr onmouseover="this.style.cursor=\'hand\'" onfocus="this.style.cursor=\'hand\'" onclick=\'form.pageNow.value=12;form.submit();\' onkeypress=\'form.pageNow.value=12;form.submit();\'><font color=\'#0000FF\'>最後一頁>></font>
        </nobr>
        <input type=\'hidden\' name=\'pageNow\' value=\'1\'>
        </td></tr>
        </table>

        </table>

        <br>
        <input type="hidden" name="sql_conction" value=" UPPER(CRTID)=\'TPH\' AND DUDT>=\'1050411\'  AND DUDT<=\'1050411\'  AND SYS=\'V\'  ORDER BY  DUDT,DUTM,CRMYY,CRMID,CRMNO">
        <input type="hidden" name="pageTotal" value="12">
        <input type="hidden" name="pageSize" value="15">
        <input type="hidden" name="rowStart" value="1">
        </form>

        <DIV align=center>
        <CENTER>
        <TABLE cellPadding=1 width="100%" border=0>
          <TBODY>
          <TR>
            <TD>
              <DIV align=center>


        </DIV></TD></TR></TBODY></TABLE>
            <TABLE class=big cellSpacing=0 cellPadding=2 width=640 align=center border=0>
              <TBODY>
              <TR>
                <TD vAlign=top width=44 height=20><FONT size=2>說明 :</FONT></TD>
                <TD vAlign=top width=12 height=20><FONT size=2>1. </FONT></TD>
                <TD vAlign=top width=584 height=20 align="left"><FONT size=2>本庭期僅供參考，如有闕漏、不符者，以實際開庭通知單為準，若查無庭期，請逕向該管法院查詢。</font></TD>
              </TR>
              <TR>
                <TD vAlign=top height=20><FONT size=2>&nbsp;</FONT></TD>
                <TD vAlign=top height=20><FONT size=2>2.</FONT></TD>
                <TD vAlign=top height=20 align="left"><FONT size=2>本系統僅提供尚未開庭之庭期查詢，恕不提供已開庭期之查詢，尚
                  祈見諒。</font></TD>
              </TR>
              <TR>
                <TD vAlign=top width=44 height=20><FONT size=2>&nbsp;</FONT></TD>
                <TD vAlign=top height=20><FONT size=2>3.</FONT></TD>
                <TD vAlign=top height=20 align="left"><FONT size="2" color="red">Android手機之庭期表查詢程式 需 Android 2.2(含)以上版本</font></TD>
              </TR>
              <TR>
              <TR>
                <TD vAlign=top width=44 height=20><FONT size=2>&nbsp;</FONT></TD>
                <TD vAlign=top height=20><FONT size=2>4.</FONT></TD>
                <TD vAlign=top height=20 align="left"><FONT size=2>對本系統若有任何疑議建言，歡迎來信指教。</font></TD>
              </TR>
              <TR>
                <TD vAlign=top width=44 height=20><FONT size=2>&nbsp;</FONT></TD>
                <TD vAlign=top height=20><FONT size=2>4.</FONT></TD>
                <TD vAlign=top height=20 align="left"><FONT size=2>下載測試<a href="javascript:downloadAffair()">
                  cvs </a> 下載&nbsp;</font></TD>
              </TR>
              <TR>
                <TD vAlign=top colspan="3" height=20 align="center"><FONT size=2>&nbsp;</FONT>
                  <font size=2>建議您使用800*600全彩及 <a href="http://www.microsoft.com/taiwan/products/ie/" target="_blank" title="下載IE">
                  Explorer 5.5 </a> 版本以上瀏覽器&nbsp;</font> </TD>
              </TR>

              </TBODY>
            </TABLE>


        <TABLE height=33 cellSpacing=0 cellPadding=0 width=760 align=center border=0>
          <TBODY>
          <TR>
            <TD background="../image/welcome.gif">
              <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
                <TBODY>
                <TR>
                  <TD width="12%">&nbsp;</TD>
                  <TD width="75%">
                    <DIV align=center><FONT size=2><A href="http://www.judicial.gov.tw/"
                    target=_parent>司法院</A> 資訊管理處 製作。 對於本系統功能有任何建議，<A
                    href="http://www.judicial.gov.tw/email/write.htm" target=_blank>
                    歡迎來信</A></FONT>。</DIV></TD>
                  <TD
        width="13%">&nbsp;</TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></CENTER></DIV>
        </body>
        </html>
      ')

    stub_request(:get, /http:\/\/csdi\.judicial\.gov\.tw\/abbs\/wkw\/WHD3A01_DOWNLOADCVS\.jsp/).
      to_return(:status => 200, :body => File.read("#{Rails.root}/spec/fixtures/scrap_data/tph_dpt.csv"))
  end
end
