<?php

?>
<table class="items table table-bordered">
    <?php foreach ($product_types as $product_type){ ?>
    <tr>
        <td><?=  $product_type->getName(); ?></td>
        <td>
            <?= $data['all'][$product_type->id]?>

        </td>
    </tr>
<?php } ?>
</table>