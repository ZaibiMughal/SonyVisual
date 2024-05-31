<?php

?>
<table class="items table table-bordered">
    <?php foreach ($product_types as $product_type){ ?>
    <tr>
        <td><?=  $product_type->getName(); ?></td>
        <td>
            100
        </td>
    </tr>
<?php } ?>
<!--    <tr>
        <td>Installments</td>
        <td>
            100
        </td>
    </tr>-->
</table>