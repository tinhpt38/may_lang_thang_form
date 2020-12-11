String emailTemplate(
    String name, String phone, String rent, String indexOnboard, String now) {
  return ''' 
  <!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body style="position: relative; width: 420px; height: 595px; background-color: #fffff;" >
    <img style="position: absolute; width: 420px; height: 199px; left: 0px; top: 0px; "
        src="https://dl.dropboxusercontent.com/s/of5ebf5azs4u36p/logo_top_web.png">

    <p style="position: absolute;
    width: 420px;
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
        " id="customerName"> ${name.toUpperCase()}</p>
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
        
        color: #000000;" id="customerPhone">$phone</p>
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
        
        color: #000000;" id="rent">$rent
        </p>
    </div>
    <div>
        <p style = "position: absolute;
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
        <p style = "position: absolute;
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
        <p style = "
        position: absolute;
        width: 160px;
        height: 16px;
        left: 35px;
        top: 450px;
        font-family: Roboto;
        font-style: normal;
        font-weight: normal;
        font-size: 14px;
        line-height: 16px;
        text-align: left;
        color: #000000;
        ">NGÀY TẠO</p>
        <p style = "
        position: absolute;
        width: 145px;
        height: 16px;
        left: 216px;
        top: 450px;
        
        font-family: Roboto;
        font-style: normal;
        font-weight: bold;
        font-size: 14px;
        line-height: 16px;
        text-align: left;
        
        color: #000000;
        " id="createAt">$now</p>
    </div>
    <div style = "position: absolute;
    width: 342px;
    height: 0px;
    left: 36px;
    top: 500px;
    
    border: 1px solid #000000;"> </div> 
    <div>
        <p style="position: absolute;
        width: 160px;
        height: 14px;
        left: 47px;
        top: 518px;
        
        font-family: Roboto;
        font-style: normal;
        font-weight: bold;
        font-size: 12px;
        line-height: 14px;
        /* identical to box height */
        
        text-align: left;
        
        color: #000000;">MÂY LANG THANG</p>
        <p style="position: absolute;
        width: 160px;
        height: 14px;
        left: 47px;
        top: 543px;
        
        font-family: Roboto;
        font-style: normal;
        font-weight: bold;
        font-size: 12px;
        line-height: 14px;
        /* identical to box height */
        
        text-align: left;
        
        color: #000000;
        ">HOTLINE: 0969896164</p>
        <p style="
        position: absolute;
        width: 160px;
        height: 14px;
        left: 47px;
        top: 566px;
        display:none;
        font-family: Roboto;
        font-style: normal;
        font-weight: bold;
        font-size: 12px;
        line-height: 14px;
        /* identical to box height */
        
        text-align: left;
        
        color: #000000;">ZALO: 0352974899</p>
    </div>
</body>

</html>
  
  ''';
}
