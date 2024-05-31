<?php
/**
 * load required classes.
 */
use common\models\Appointment;
use common\models\User;
use common\models\Enquiry;

$user = new User();

?>

    <script type="text/javascript">
        $(function () {
            $('#container').highcharts({
                    title: {
                        text: '<?=Yii::t('app', 'General Statistics (Desktop & Mobile)')?>',
                        x: -20 //center
                    },
                    subtitle: {
                        text: 'SalamatAutoCorporation.com',
                        x: -20
                    },
                    xAxis: {
                        reversed: true,
                        categories: [
                            <?php
                            for ($i = 0; $i < 12; ++$i) {
                                echo "'".date('M Y', strtotime('-'.$i.' month', strtotime(date('1 M Y'))))."',";
                            }
                            ?>
                        ]
                    },
                    yAxis: {
                        title: {
                            text: '',
                        },
                        plotLines: [{
                            value: 0,
                            width: 1,
                            color: '#808080'
                        }]
                    },

                    legend: {
                        layout: 'vertical',
                        align: 'center',
                        verticalAlign: 'bottom',
                        borderWidth: 0
                    },
                    exporting: {enabled: true},
                    series: [
                        <?php foreach ($product_types as $product_type){ ?>
                        {
                            name: '<?= $product_type->getName()?>',
                            data: [
                                <?php
                                for ($i = 0; $i < 12; ++$i) {

                                    echo \common\models\ProductBooking::getSalesReport($product_type, strtotime('-'.$i.' month'), $payment_model).',';
//                                    echo $user->countMonthPatients($country_id, strtotime('-'.$i.' month', strtotime(date('1 M Y')))).',';
                                }
                                ?>
                            ],
                            lineWidth: 3
                        },
                        <?php } ?>
                    ]
                });
            }
        );
    </script>


<script src="https://code.highcharts.com/highcharts.js"></script>

<!--<script src="/charts/js/highcharts.js"></script>-->
<!--<script src="/charts/js/modules/exporting.js"></script>-->
<div id="container" style="width: 100%; height: 500px; margin: 0 auto 50px"></div>
