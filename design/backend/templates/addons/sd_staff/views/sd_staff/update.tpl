{if $staff_member}
    {assign var="id" value=$staff_member.staff_id}
{else}
    {assign var="id" value=0}
{/if}
{$allow_save = $staff_member|fn_allow_save_object:"sd_staff"}
{$hide_inputs = ""|fn_check_form_permissions}
{capture name="mainbox"}
<form name="staff_member_form" enctype="multipart/form-data" action="{""|fn_url}" method="post"
      class="form-horizontal form-edit {if ($runtime.company_id && $id && $user_data.company_id != $runtime.company_id && $id != $auth.user_id) || $hide_inputs} cm-hide-inputs{/if}">
    <input type="hidden" class="cm-no-hide-input" name="staff_id" value="{$id}"/>
    {capture name="tabsbox"}
        <div id="content_general">
            {hook name="sd_staff:general_content"}
                {include file="common/subheader.tpl" title=__("sd_staff.info_staff_member")}
                {include file="addons/sd_staff/views/sd_staff/components/staff_member_fields.tpl" }
            {/hook}
        </div>
        {hook name="sd_staff:general_content"}
        {/hook}
    {/capture}
    {include file="common/tabsbox.tpl" content=$smarty.capture.tabsbox active_tab=$smarty.request.selected_section track=true}
    {/capture}

    {if !$id}
        {$title = "{__("add_staff_member")}: `$_user_desc`"}
    {else}
        {$title = "`$staff_member.firstname` `$staff_member.lastname`"}
    {/if}

    {capture name="tools_list"}
        {hook name="promotions:list_extra_links"}
        {if $allow_save}
            <li>{btn type="list" text=__("add") href="sd_staff.add"}</li>
            <li>{btn type="list" text=__("delete") class="cm-confirm" href="sd_staff.delete?staff_id=`$staff_member.staff_id`" method="POST"}</li>
            <li>{btn type="list" text=__("list")  href="sd_staff.manage"}</li>
        {/if}
        {/hook}
    {/capture}


    {capture name="buttons"}
        <div class="btn-group btn-hover dropleft btn-toolbar">
            {hook name="staff_member:update_buttons"}
            {if $id}
                {dropdown content=$smarty.capture.tools_list}

                {include file="buttons/save_cancel.tpl" but_meta="dropdown-toggle" but_role="submit-link" but_name="dispatch[sd_staff.`$runtime.mode`]" but_target_form="staff_member_form" save=$id}
            {else}
                {include file="buttons/button.tpl" but_text=__("create") but_meta="dropdown-toggle" but_role="submit-link" but_name="dispatch[sd_staff.`$runtime.mode`]" but_target_form="staff_member_form" save=$id}
            {/if}
            {/hook}
        </div>
    {/capture}

    {include file="common/mainbox.tpl"
    title=$title
    content=$smarty.capture.mainbox
    buttons=$smarty.capture.buttons
    }
</form>
