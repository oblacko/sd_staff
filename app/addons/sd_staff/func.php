<?php
defined('BOOTSTRAP') or die('Access denied');

use Tygh\Navigation\LastView;

function fn_get_staff($params = array(), $lang_code = CART_LANGUAGE)
{
    // Init filter
    $params = LastView::instance()->update('sd_staff', $params);
    $params = array_merge(array(
        'items_per_page' => 0,
        'page' => 1,
    ), $params);

    $fields = array(
        'staff_id',
        'firstname',
        'lastname',
        'function',
        'status',
        'phone',
        'email'
    );

    $sortings = array (
        'id' => 'staff_id',
        'name' => array('lastname', 'firstname'),
        'status' => 'status',
        'function' => 'function'
    );

    $condition = array();

    if (isset($params['id']) && fn_string_not_empty($params['id'])) {
        $params['id'] = trim($params['id']);
        $condition[] = db_quote("staff_id = ?i", $params['id']);
    }

    if (isset($params['name']) && fn_string_not_empty($params['name'])) {
        $params['name'] = trim($params['name']);
        $condition[] = db_quote("firstname LIKE ?l", '%' . $params['name'] . '%');
    }

    if (isset($params['name']) && fn_string_not_empty($params['name'])) {
        $params['name'] = trim($params['name']);
        $condition[] = db_quote("lastname LIKE ?l", '%' . $params['name'] . '%');
    }

    if (isset($params['function']) && fn_string_not_empty($params['function'])) {
        $params['function'] = trim($params['function']);
        $condition[] = db_quote("function LIKE ?l", '%' . $params['function'] . '%');
    }

    if (!empty($params['status'])) {
        $condition[] = db_quote("status = ?s", $params['status']);
    }

    $fields_str = implode(', ', $fields);
    $condition_str = $condition ? (' WHERE ' . implode(' AND ', $condition)) : '';
    $sorting_str = db_sort($params, $sortings, 'date', 'desc');

    $limit = '';
    if (!empty($params['items_per_page'])) {
        $params['total_items'] = db_get_field(
            "SELECT COUNT(staff_id) FROM ?:sd_staff" . $condition_str
        );
        $limit = db_paginate($params['page'], $params['items_per_page'], $params['total_items']);
    }


    $items = db_get_array(
        "SELECT " . $fields_str
        . " FROM ?:sd_staff"
        . $condition_str
        . $sorting_str
        . $limit
    );

    LastView::instance()->processResults('sd_staff', $items, $params);

    return [$items, $params];
}

function fn_delete_staff($staff_id)
{
    return db_query("DELETE FROM ?:sd_staff WHERE staff_id = ?i", $staff_id);
}

function fn_staff_update($data, $staff_id)
{

    if (!empty($staff_id)) {
        db_query("UPDATE ?:sd_staff SET ?u WHERE staff_id = ?i", $data, $staff_id);
    }

    return $staff_id;
}
