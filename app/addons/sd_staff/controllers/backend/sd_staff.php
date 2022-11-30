<?php
use Tygh\Registry;

defined('BOOTSTRAP') or die('Access denied');

/** @var $mode string */

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    if ($mode === 'delete') {
        if ($_REQUEST['staff_id']) {
            fn_delete_staff($_REQUEST['staff_id']);
        }
        $suffix = ".manage";
    }

    if ($mode === 'm_delete') {
        if (!empty($_REQUEST['staff_ids'])) {
            foreach ($_REQUEST['staff_ids'] as $v) {
                fn_delete_staff($v);
            }
        }
        $suffix = ".manage";
    }

    if (
        $mode === 'm_update_statuses'
        && !empty($_REQUEST['staff_ids'])
        && is_array($_REQUEST['staff_ids'])
        && !empty($_REQUEST['status'])
    ) {
        $status_to = (string) $_REQUEST['status'];

        foreach ($_REQUEST['staff_ids'] as $staff_id) {

            fn_tools_update_status([
                'table'             => 'sd_staff',
                'status'            => $status_to,
                'id_name'           => 'staff_id',
                'id'                => $staff_id,
                'show_error_notice' => false
            ]);
        }

        if (defined('AJAX_REQUEST')) {
            $redirect_url = fn_url('sd_staff.manage');
            if (isset($_REQUEST['redirect_url'])) {
                $redirect_url = $_REQUEST['redirect_url'];
            }
            Tygh::$app['ajax']->assign('force_redirection', $redirect_url);
            Tygh::$app['ajax']->assign('non_ajax_notifications', true);
            return [CONTROLLER_STATUS_NO_CONTENT];
        }
    }

    if ($mode === 'add') {
        $staff_id = db_query('INSERT INTO ?:sd_staff ?e', $_REQUEST['staff_member_data']);
        $suffix = ".update?staff_id={$staff_id}";
    }

    if ($mode === 'update') {
       if($_REQUEST['staff_id']&&$_REQUEST['staff_member_data']){
           fn_staff_update($_REQUEST['staff_member_data'],$_REQUEST['staff_id']);
           $suffix = ".update?staff_id={$_REQUEST['staff_id']}";
       }
    }

    return array(CONTROLLER_STATUS_OK, 'sd_staff' . $suffix);
}

if ($mode == 'update' || $mode == 'add') {

    $staff_id = !empty($_REQUEST['staff_id']) ? $_REQUEST['staff_id'] : 0;

    if($staff_id){

        $staff_member = db_get_row("SELECT * FROM ?:sd_staff WHERE staff_id = ?i", $staff_id );

        Registry::set('navigation.tabs', array (
            'general' => array (
                'title' => __('general'),
                'js' => true
            ),
        ));
    }

    Tygh::$app['view']->assign('staff_member',$staff_member);
}

if ($mode == 'manage') {

    $params = array_merge(
        ['items_per_page' => Registry::get('settings.Appearance.admin_elements_per_page')],
        $_REQUEST
    );

    list($staff_list, $search) = fn_get_staff($params, DESCR_SL);
    $order_statuses = fn_get_statuses(STATUSES_ORDER);
    $statuses = fn_get_default_statuses(true,false);

    Tygh::$app['view']
        ->assign('staff_list', $staff_list)
        ->assign('search', $search)
        ->assign('statuses', $statuses)
        ->assign('order_statuses', $order_statuses);
}
