<?php
use Tygh\Registry;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

/** @var $mode string */

if ($mode == 'view') {

    $params = array_merge(
        ['items_per_page' => Registry::get('settings.Appearance.elements_per_page')],
        $_REQUEST
    );

    list($staff_list, $search) = fn_get_staff($params, DESCR_SL);
    fn_add_breadcrumb('sd_staff.staff', 'index.php?dispatch=sd_staff.view');

    Tygh::$app['view']
        ->assign('staff_list', $staff_list)
        ->assign('search', $search);
}
