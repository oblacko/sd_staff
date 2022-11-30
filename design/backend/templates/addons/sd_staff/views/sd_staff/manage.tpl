{script src="js/tygh/backend/pages_bulk_edit.js"}
{capture name="mainbox"}
<form action="{""|fn_url}" method="post" id="staff_list_form" name="staff_list_form"
      class="{if ""|fn_check_form_permissions} cm-hide-inputs{/if}">

    {include file="common/pagination.tpl" save_current_page=true save_current_url=true div_id=$smarty.request.content_id}

    {$return_url = $config.current_url|escape:"url"}
    {$c_url = $config.current_url|fn_query_remove:"sort_by":"sort_order"}
    {if $staff_list}
        {capture name="staff_list_table"}
            <div class="table-responsive-wrapper">
                <table class="table table-middle table--relative table-responsive longtap-selection">
                    <thead
                            data-ca-bulkedit-default-object="true"
                            data-ca-bulkedit-component="defaultObject"
                    >
                    <tr>
                        <th width="5%" class="mobile-hide">
                            {include file="common/check_items.tpl" check_statuses=$statuses}

                            <input type="checkbox"
                                   class="bulkedit-toggler hide"
                                   data-ca-bulkedit-disable="[data-ca-bulkedit-default-object=true]"
                                   data-ca-bulkedit-enable="[data-ca-bulkedit-expanded-object=true]"
                            />
                        </th>

                        <th width="5%">
                            {include file="common/table_col_head.tpl" type="id"}
                        </th>
                        <th width="25%">
                            {include file="common/table_col_head.tpl"
                            type="name"
                            text=__("sd_staff.full_name")
                            }
                        </th>
                        <th width="25%">
                            {include file="common/table_col_head.tpl"
                            type="function"
                            text=__("sd_staff.function")
                            }
                        </th>
                        <th width="5%" class="mobile-hide">&nbsp;</th>
                        <th width="5%" class="right">
                            {include file="common/table_col_head.tpl" type="status"}
                        </th>
                    </tr>
                    </thead>

                    {foreach from=$staff_list item=staff}

                        {$allow_save=$staff|fn_allow_save_object:"staff_list"}

                        {if $allow_save}
                            {$link_text=__("edit")}
                            {$additional_class="cm-no-hide-input"}
                            {$status_display=""}
                        {else}
                            {$link_text=__("view")}
                            {$additional_class="cm-hide-inputs"}
                            {$status_display="text"}
                        {/if}
                        <tr class="cm-row-status-{$staff.status|lower} cm-longtap-target {$additional_class}"
                            data-ca-longtap-action="setCheckBox"
                            data-ca-longtap-target="input.cm-item"
                            data-ca-id="{$staff.staff_id}"
                        >
                            <td width="5%" class="mobile-hide">
                                <input name="staff_ids[]" type="checkbox" value="{$staff.staff_id}"
                                       class="cm-item cm-item-status-{$staff.status|lower} hide"/></td>
                            <td width="5%" data-th="{__("id")}">
                                <p class="row-status">{$staff.staff_id}</p>
                            </td>
                            <td data-th="{__("name")}">
                                <a class="row-status"
                                   href="{"sd_staff.update?staff_id=`$staff.staff_id`"|fn_url}">{$staff.firstname} {$staff.lastname}</a>
                            </td>
                            <td data-th="{__("staff_function_title")}">
                               <p class="row-status">{$staff.function}</p>
                            </td>
                            <td width="5%" class="right mobile-hide">
                                <div class="hidden-tools">
                                    {capture name="tools_list"}
                                        {hook name="promotions:list_extra_links"}
                                            <li>{btn type="list" text=$link_text href="sd_staff.update?staff_id=`$staff.staff_id`"}</li>
                                        {if $allow_save}
                                            <li>{btn type="list" text=__("delete") class="cm-confirm" href="sd_staff.delete?staff_id=`$staff.staff_id`" method="POST"}</li>
                                        {/if}
                                        {/hook}
                                    {/capture}
                                    {dropdown content=$smarty.capture.tools_list}
                                </div>
                            </td>
                            <td width="5%" class="nowrap right" data-th="{__("status")}">
                                {include file="common/select_popup.tpl" popup_additional_class="dropleft" display=$status_display id=$staff.staff_id status=$staff.status hidden=false object_id_name="staff_id" table="sd_staff"}
                            </td>
                        </tr>
                    {/foreach}
                </table>
            </div>
        {/capture}

        {include file="common/context_menu_wrapper.tpl"
        form="staff_list_form"
        object="sd_staff"
        items=$smarty.capture.staff_list_table
        }
    {else}
        <p class="no-items">{__("no_data")}</p>
    {/if}

    {include file="common/pagination.tpl" div_id=$smarty.request.content_id}

    {capture name="adv_buttons"}
            {include file="common/tools.tpl" tool_href="sd_staff.add" prefix="top" hide_tools="true" link_text='' title=__("add_staff_member") icon="icon-plus"}
    {/capture}

</form>
{/capture}


{include file="common/mainbox.tpl" title=__("sd_staff") content=$smarty.capture.mainbox  buttons=$smarty.capture.buttons adv_buttons=$smarty.capture.adv_buttons content_id="manage_sd_staff"}

{*TODO order_status*}