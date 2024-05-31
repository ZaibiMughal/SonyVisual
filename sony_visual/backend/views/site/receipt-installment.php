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
        <h3 style="font-weight: bold;text-decoration: underline;">Installment Receipt</h3>
    </div>
</div>
<br>
<div class="container-fluid">
    <div class="d-flex">
        <div>
            <h5><strong>Receipt No:</strong> 12345</h5>
        </div>
        <div class="ml-auto">
            <h5><strong>Print Date:</strong> 12345</h5>
        </div>
    </div>
</div>
<div class="container-fluid" id="receipt_container" style="padding-top: 25px;
    padding-bottom: 10px; font-family: sans-serif;" >
    <div class="d-flex">
        <div class="col-md-6" style="font-size: 20px;line-height: 3.5rem;">
        ہمیشہ دفتر میں اپنی قسط ادا کریں اور کمپیوٹرائزڈ رسید حاصل کریں۔ مینجمنٹ کمپیوٹرائزڈ رسید کے بغیر لین دین کا ذمہ دار نہیں ہوگی۔
        </div>
        <div class="ml-auto" style="font-size: 20px;text-align: right;
    margin: auto 0;
    width: 100%;">قسط ہر ماہ کی <span style="    border: 2px solid black;
    padding-left: 10px;
    padding-right: 10px;
    border-radius: 5px;"><strong>5</strong></span> تاریخ کو ادا کی جائے۔
        </div>
    </div>
</div>
<div class="container-fluid" id="receipt_container" style="margin-top: 5px">
    <div class="row">
        <div class="col-md-10">
            <table class="items table table-bordered">
                <tr>
                    <td><strong>Account No: </td>
                    <td>1234</td>

                    <td><strong>Installment Due Date: </td>
                    <td><?= date("d-m-Y")?></td>
                </tr>
                <tr>
                    <td><strong>Customer Name: </td>
                    <td>Zohaib</td>

                    <td><strong>Father Name: </td>
                    <td>Yousaf</td>
                </tr>
                <tr>
                    <td><strong>Installment Fee: </td>
                    <td>5000</td>

                    <td><strong>Installment(Receiving) Date: </td>
                    <td><?= date("d-m-Y")?></td>
                </tr>
                <tr>
                    <td><strong>Previous Balance: </td>
                    <td>10000</td>

                    <td><strong>Remaining Balance: </td>
                    <td>5000</td>
                </tr>
                <tr>
                    <td><strong>Received By: </td>
                    <td>Hanif Khan</td>

                    <td><strong>Received Place: </td>
                    <td>Office</td>
                </tr>
                <tr>
                    <td><strong>Remaing Installments: </td>
                    <td style="border-right: none;">Your remaining installment are 5</td>
                </tr>
            </table>
        </div>
            <div class="col-md-2">
                <table class="items table table-bordered">
                    <th>Received By</th>
                    <tr>
                        <td style="font-size: 18px;height: 147px; width: 100%; word-break: break-all;"><strong style="font-size: 22px;"> Hanif Khan </strong><br>03002312223</td>
                    </tr>
                </table>
            </div>
    </div>


</div>

<div class="container-fluid" id="receipt_container" style="margin-top: 5px">
    <h5><strong>Need Help? </strong> Please call us on any given number: 03086599977, 03004579736, 03177332893</h5>
    <h5><strong>Solution By:  </strong> SmartIntel +923246614002</h5>

</div>

