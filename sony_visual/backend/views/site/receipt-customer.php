<?php
/* @var $this yii\web\View */

use common\models\PaymentType;
use yii\bootstrap4\Tabs;

?>
<style>
    #receipt_container {
        border: 2px solid black;
        padding: 10px;
    }
    .row {
         margin-right: 0 !important;
         margin-left: 0 !important;
    }
    .customer_image{
        border: none;
        margin: 0;
        padding: 0;
        width: 100%;
        height: 100%;
        font-size:0;
    }
</style>
<div class="container-fluid" id="receipt_container" >
    <div class="row justify-content-center align-items-center">
        <img src="/images/logo.png" style="width: 7%">
    </div>

    <div class="row justify-content-center align-items-center">
        <h2 style="font-weight: bold">Salamat Auto Corporation</h2>
    </div>
    <div class="row justify-content-center align-items-center" >
        <h4>Feroz-wala Road Shahzada Shaheed Colony St#12 Mohammadi Choak, Gujranwala</h4>
    </div>
    <div class="row justify-content-center align-items-center" >
        <h3 style="font-weight: bold;text-decoration: underline;">Customer Details</h3>
    </div>
</div>
<br>
<div class="container-fluid">
    <div class="d-flex">
        <div>
            <h5><strong>Print Date:</strong> 12345</h5>
        </div>
    </div>
</div>
<div class="container-fluid" id="receipt_container" style="margin-top: 5px">
    <div class="row">
        <div class="col-md-10">
            <table class="items table table-bordered">
                <tr>
                    <td><strong>Customer ID: </td>
                    <td>1234</td>

                    <td><strong>Account No: </td>
                    <td>1234</td>
                </tr>
                <tr>
                    <td><strong>Customer Name: </td>
                    <td>Zohaib</td>

                    <td><strong>Father Name: </td>
                    <td>Yousaf</td>
                </tr>
                <tr>
                    <td><strong>CNIC: </td>
                    <td>341018822882828</td>

                    <td><strong>Cell Phone No: </td>
                    <td>03246614002</td>
                </tr>
                <tr>
                    <td><strong>Date registered: </td>
                    <td><?= date("d-m-Y")?></td>

                    <td><strong>Registered By: </td>
                    <td>Hanif Khan</td>
                </tr>
                <tr>
                    <td><strong>Customer of Whome: </td>
                    <td>Hanif Khan</td>
                    <td><strong>Address: </td>
                    <td style="border-right: none;">Feroz-wala Road Shahzada Shaheed Colony St#12 Mohammadi Choak, Gujranwala</td>
                </tr>
            </table>
        </div>
            <div class="col-md-2">
                <table class="items table table-bordered">
                    <tr>
                        <td style="height: 170px; width: 100%; word-break: break-all;"><img class="customer_image" src="/images/customer/my_photo.jpeg"></td>
                    </tr>
                </table>
            </div>
    </div>
</div>

<div class="container-fluid" style="margin-top: 20px">
    <div class="d-flex">
        <div>
            <h5><strong>Guaranters:</strong></h5>
        </div>
    </div>
</div>
<div class="container-fluid" id="receipt_container" style="margin-top: 5px">
    <div class="row">
        <div class="col-md-12">
            <table class="items table table-bordered">
                <th>Name</th>
                <th>Father Name</th>
                <th>Cell No</th>
                <th>CNIC</th>
                <th>Address</th>
                <tr>
                    <td>Shoaib</td>
                    <td>Yousaf</td>
                    <td>03246005605</td>
                    <td>34101772237627</td>
                    <td>Feroz-wala Road Shahzada Shaheed Colony St#12 Mohammadi Choak, Gujranwala</td>
                </tr>
                <tr>
                    <td>Shoaib</td>
                    <td>Yousaf</td>
                    <td>03246005605</td>
                    <td>34101772237627</td>
                    <td>Feroz-wala Road Shahzada Shaheed Colony St#12 Mohammadi Choak, Gujranwala</td>
                </tr>
            </table>
        </div>
    </div>
</div>

<div class="container-fluid" style="margin-top: 20px">
    <div class="d-flex">
        <div>
            <h5><strong>Product:</strong></h5>
        </div>
    </div>
</div>
<div class="container-fluid" id="receipt_container" style="margin-top: 5px">
    <div class="row">
        <div class="col-md-12">
            <table class="items table table-bordered">
                <tr>
                    <td><strong>Product Type: </td>
                    <td>Motor Bike</td>

                    <td><strong>Product Model: </td>
                    <td>Honda CD 70</td>
                </tr>
                <tr>
                    <td><strong>Color: </td>
                    <td>Red</td>

                    <td><strong>Company: </td>
                    <td>Honda</td>
                </tr>
                <tr>
                    <td><strong>Engine No: </td>
                    <td>ASLJDLAJD</td>

                    <td><strong>Chassis No: </td>
                    <td>SLAKDJLKAJ</td>
                </tr>
                <tr>
                    <td><strong>Product Price: </td>
                    <td>100000</td>

                    <td><strong>Advance: </td>
                    <td>40000</td>
                </tr>
                <tr>
                    <td><strong>Total installments: </td>
                    <td>12</td>

                    <td><strong>Installment Fee: </td>
                    <td>5000</td>
                </tr>
<!--                <tr>-->
<!--                    <td><strong>Previous Balance: </td>-->
<!--                    <td>12</td>-->
<!---->
<!--                    <td><strong>Remaining Balance: </td>-->
<!--                    <td>5000</td>-->
<!--                </tr>-->
            </table>
        </div>
    </div>
</div>

<div class="container-fluid" style="margin-top: 20px">
    <div class="d-flex">
        <div>
            <h5><strong>Installments Details:</strong></h5>
        </div>
    </div>
</div>
<div class="container-fluid" id="receipt_container" style="margin-top: 5px">
    <div class="row">
        <div class="col-md-12">
            <table class="items table table-bordered">
                <th>Sr#</th>
                <th>Installment Fee</th>
                <th>Dua Date</th>
                <th>Date Received</th>
                <th>Received By</th>
                <th>Received At</th>
                <tr>
                    <td>1</td>
                    <td>5000</td>
                    <td><?= Date('05-m-Y')?></td>
                    <td><?= Date('05-m-Y')?></td>
                    <td>Hanif Khan</td>
                    <td>Office</td>
                </tr>
            </table>
        </div>
    </div>
</div>

<div class="container-fluid" id="receipt_container" style="margin-top: 5px">
    <h5><strong>Need Help? </strong> Please call us on any given number: 03086599977, 03004579736, 03177332893</h5>
    <h5><strong>Solution By:  </strong> SmartIntel +923246614002</h5>

</div>

