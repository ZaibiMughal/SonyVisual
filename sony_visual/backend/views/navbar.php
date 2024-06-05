<!-- Added By Zohaib -->
<!--<style>-->
<!--    .navbar .container, .navbar .container-fluid {-->
<!--        padding-right: 0px;-->
<!--        padding-left: 0px;-->
<!--    }-->
<!--</style>-->


<?php

use common\models\Product;
use yii\bootstrap4\Nav;
use yii\bootstrap4\NavBar;
use yii\helpers\Html;
use yii\helpers\Url;


NavBar::begin([
    'brandLabel' => '<img src="/images/logo.png" style="width: 60px;height: 55px; border-radius: 4px; background-color: white;" />',
    'brandUrl' => Yii::$app->homeUrl,
    'options' => [
        'class' => 'navbar navbar-dark navbar-expand-md navbar-redDark fixed-top',
//        'class' => 'navbar navbar-expand-md navbar-redDark fixed-top',
    ],
]);

$menuItems = [
    ['label' => 'User', 'url' => Url::to('/user')],

//    [
//        'label' =>'User',
//        'items' => [
//            ['label' => 'User', 'url' => Url::to('/User')],
//            ['label' => 'User Type', 'url' => Url::to('/user-type')],
////            ['label' => 'Customer', 'url' => Url::to('/customer')],
//        ],
//        'visible' => Yii::$app->user->identity->isMasterUser()
//    ],
    ['label' => 'Video Post', 'url' => Url::to('/video-post')],
    ['label' => 'Favorite Video', 'url' => Url::to('/video-favorite')],


];


?>

<?php
echo Nav::widget([
    'options' => ['class' => 'navbar-nav mr-auto'],
    'items' => $menuItems,
]);

if (!Yii::$app->user->isGuest) {
    $userMenu = [
        [
            'label' => 'Settings',
            'url' => '/',
            'items' => [
                ['label' => 'Profile', 'url' => Yii::$app->user->identity->getCurrentUrl()],
                ['label' => 'Change password', 'url' => Url::to('/user/change-password')],
//                ['label' => 'Take Backup', 'url' => Url::to('/site/backup')],
                [
                    'label' => 'Logout',
                    'url' => '/site/logout',
                    'linkOptions' => ['data-method' => 'post'],
                ],
            ],
        ],
    ];
}



echo Nav::widget([
    'options' => ['class' => 'navbar-nav ml-auto'],
    'items' => $userMenu,
]);


?>


<?php
NavBar::end();


?>

<style>

    .navbar .container{
        padding-right: 0px;
        padding-left: 0px;
    }
    .pagination li.previous>a, .pagination li.next>a, .pagination li.previous>span, .pagination li.next>span {
        background-color: #000000 !important;
    }
</style>

<script>
    $(document).ready(function(){
        $('.navbar-expand-md.navbar-redDark').children()[0].setAttribute('class','container-fluid');
    });
</script>
