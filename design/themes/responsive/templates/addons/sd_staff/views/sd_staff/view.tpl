{include file="common/pagination.tpl"}

<table class="ty-table">
    <thead>
    <tr>
        <th>{__("id")}</th>
        <th>{__("sd_staff.function")}</th>
        <th>{__("sd_staff.full_name")}</th>
        <th>{__("email")}</th>
        <th>{__("phone")}</th>
    </tr>
    </thead>
    {foreach from=$staff item="o"}
        <tr>
            <td class="ty-orders-search__item"><strong>#{$o.staff_id}</strong></td>
            <td class="ty-orders-search__item">{$o.function}</td>
            <td class="ty-orders-search__item">{$o.firstname} {$o.lastname}</td>
            <td class="ty-orders-search__item">{$o.email}</td>
            <td class="ty-orders-search__item">{$o.phone}</td>
        </tr>
        {foreachelse}
        <tr class="ty-table__no-items">
            <td colspan="7">
                <p class="ty-no-items">{__("text_no_orders")}</p>
            </td>
        </tr>
    {/foreach}
</table>

{include file="common/pagination.tpl"}

{capture name="mainbox_title"}{__("sd_staff.staff")}{/capture}
