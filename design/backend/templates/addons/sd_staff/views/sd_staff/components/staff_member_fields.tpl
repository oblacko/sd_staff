
<div class="control-group">
    <label for="elm_staff_member_data_function" class="control-label cm-required" >{__("sd_staff.function")}</label>
    <div class="controls">
        <input type="text" id="elm_staff_member_data_function" name="staff_member_data[function]" size="32"
               value="{$staff_member.function}"
               class="input-large">
    </div>
</div>
<div class="control-group">
    <label for="elm_staff_member_data_firstname" class="control-label cm-required">{__("first_name")}</label>
    <div class="controls">
        <input type="text" id="elm_staff_member_data_firstname" name="staff_member_data[firstname]" size="32"
               value="{$staff_member.firstname}"
               class="input-large ">
    </div>
</div>
<div class="control-group">
    <label for="elm_staff_member_data_lastname" class="control-label cm-required">{__('last_name')}</label>
    <div class="controls">
        <input type="text" id="elm_staff_member_data_lastname" name="staff_member_data[lastname]" size="32"
               value="{$staff_member.lastname}"
               class="input-large ">
    </div>
</div>
<div class="control-group">
    <label for="elm_staff_member_data_phone" class="control-label cm-required cm-mask-phone-label">{__("phone")}</label>
    <div class="controls">
        <input type="text" id="elm_staff_member_data_phone" name="staff_member_data[phone]" size="32" value="{$staff_member.phone}"
               class="input-large cm-mask-phone js-mask-phone-inited" inputmode="numeric">
    </div>
</div>
<div class="control-group">
    <label for="elm_staff_member_data_email" class="control-label cm-required cm-email">{__("email")}</label>
    <div class="controls">
        <input type="text" id="elm_staff_member_data_email" name="staff_member_data[email]" class="input-large" size="48"
               maxlength="128"
               value="{$staff_member.email}">
    </div>
</div>
<div class="control-group">
    <label for="description" class="control-label">{__("description")}</label>
    <div class="controls">
        <input type="hidden" class="cm-no-hide-input" id="description" name="staff_member_data[description]" value="{$staff_member.description}"/>
    <textarea class="cs-textarea-adaptive cs-textarea-adaptive--with-sidebar input-large cm-no-hide-input" id="staff_member_description" name="staff_member_data[description]" cols="32"
              rows="3" {$disabled_param nofilter}>{$staff_member.description}</textarea>
    </div>
</div>

<script>

</script>