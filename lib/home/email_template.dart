String emailTemplate(
    {String name,
    String phone,
    String rent,
    String indexOnboard,
    String now,
    String singer,
    String buildate}) {
  return ''' 
  <!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <div style="position: relative; width: 420px; height: 595px; background-color: #fffff;">
        <img style="position: absolute; width: 420px; height: 199px; left: 0px; top: 0px; "
            src="https://www.dropbox.com/s/of5ebf5azs4u36p/logo_top_web.png">

        <p style="position: absolute;
    width: 302px;
    height: 42px;
    left: 59px;
    top: 219px;
    font-family: Roboto;
    font-style: normal;
    font-weight: bold;
    font-size: 18px;
    line-height: 21px;
    text-align: center;
    
    color: #000000;"> XÁC NHẬN ĐĂNG KÝ ĐẶT CHỖ NGỒI
            TẠI MÂY LANG THANG </p>
        <div style="position: absolute; width: 342px; height: 0px; left: 35px; top: 290px; border: 1px solid #000000;">
        </div>
        <div>
            <p style="position: absolute;
        width: 160px;
        height: 16px;
        left: 35px;
        top: 298px;
        
        font-family: Roboto;
        font-style: normal;
        font-weight: normal;
        font-size: 14px;
        line-height: 16px;
        text-align: left;
        
        color: #000000;
        "> HỌ TÊN KHÁCH HÀNG: </p>
            <p style="position: absolute;
        width: 160px;
        height: 16px;
        left: 220px;
        top: 298px;
        
        font-family: Roboto;
        font-style: normal;
        font-weight: bold;
        font-size: 14px;
        line-height: 16px;
        text-align: left;
        color: #000000;
        " id="customerName"> $name </p>
        </div>
        <div>
            <p style="position: absolute;
        width: 160px;
        height: 16px;
        left: 35px;
        top: 336px;
        
        font-family: Roboto;
        font-style: normal;
        font-weight: normal;
        font-size: 14px;
        line-height: 16px;
        text-align: left;
        
        color: #000000;
        "> SỐ ĐIỆN THOẠI:</p>
            <p style="position: absolute;
        width: 81px;
        height: 16px;
        left: 220px;
        top: 336px;
        
        font-family: Roboto;
        font-style: normal;
        font-weight: bold;
        font-size: 14px;
        line-height: 16px;
        text-align: left;
        
        color: #000000;" id="customerPhone"> $phone</p>
        </div>

        <div>
            <p style="position: absolute;
        width: 160px;
        height: 16px;
        left: 35px;
        top: 374px;
        
        font-family: Roboto;
        font-style: normal;
        font-weight: normal;
        font-size: 14px;
        line-height: 16px;
        text-align: left;
        
        color: #000000;
        ">GIÁ GHẾ:</p>
            <p style="position: absolute;
        width: 162px;
        height: 16px;
        left: 220px;
        top: 374px;
        
        font-family: Roboto;
        font-style: normal;
        font-weight: bold;
        font-size: 14px;
        line-height: 16px;
        text-align: center;
        
        color: #000000;" id="rent">$rent</p>
        </div>
        <div>
            <p style="position: absolute;
        width: 160px;
        height: 16px;
        left: 35px;
        top: 412px;
        
        font-family: Roboto;
        font-style: normal;
        font-weight: normal;
        font-size: 14px;
        line-height: 16px;
        text-align: left;
        
        color: #000000;
        ">VỊ TRÍ</p>
            <p style="position: absolute;
        width: 160px;
        height: 16px;
        left: 220px;
        top: 412px;
        font-family: Roboto;
        font-style: normal;
        font-weight: bold;
        font-size: 14px;
        line-height: 16px;
        text-align: left;
        color: #000000;" id="indexOnBoard">$indexOnboard</p>
        </div>
        <div>
            <p style="
      position: absolute;
width: 160px;
height: 16px;
left: 35px;
top: 438px;

font-family: Roboto;
font-style: normal;
font-weight: normal;
font-size: 14px;
line-height: 16px;
text-align: left;

color: #000000;
        ">SHOW DIỄN</p>
            <p style="
      position: absolute;
width: 32px;
height: 16px;
left: 220px;
top: 438px;

font-family: Roboto;
font-style: normal;
font-weight: bold;
font-size: 14px;
line-height: 16px;
text-align: left;

color: #000000;
        " id="singer">$singer</p>
        </div>

        <div>
            <p style="
        position: absolute;
width: 160px;
height: 16px;
left: 35px;
top: 473px;

font-family: Roboto;
font-style: normal;
font-weight: normal;
font-size: 14px;
line-height: 16px;
text-align: left;

color: #000000;
        ">NGÀY DIỄN</p>
            <p style="
       position: absolute;
width: 75px;
height: 16px;
left: 220px;
top: 473px;

font-family: Roboto;
font-style: normal;
font-weight: bold;
font-size: 14px;
line-height: 16px;
text-align: left;

color: #000000;
        " id="buildDate"> $buildate</p>
        </div>



        <div>
            <p style="
       position: absolute;
width: 160px;
height: 16px;
left: 35px;
top: 508px;

font-family: Roboto;
font-style: normal;
font-weight: normal;
font-size: 14px;
line-height: 16px;
text-align: left;

color: #000000;

        ">NGÀY TẠO</p>
            <p style="
       position: absolute;
width: 75px;
height: 16px;
left: 220px;
top: 508px;

font-family: Roboto;
font-style: normal;
font-weight: bold;
font-size: 14px;
line-height: 16px;
text-align: left;

color: #000000;
        " id="createAt">$now</p>
        </div>

    </div>
</body>

</html>
  ''';
}
