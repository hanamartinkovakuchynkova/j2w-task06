[#ftl]

[#macro form method bind attributes...]
    [#assign bind = .data_model[bind] ]
    [#assign bindStatus = .data_model["org.springframework.validation.BindingResult.${bind}"] ]
    <form method="${method}" [@attrs attributes /]>
        [#nested ]
    </form>
[/#macro]

[#macro input name label type="text" attributes...]
    <div class="row">
        <label for="${name}">${label}</label>
        <input type="${type}" id="${name}" name="${name}" value="${bind[name]!}" [@attrs attributes /]>
        [@errors name=name /]
    </div>
[/#macro]

[#macro errors name]
    [#if bindStatus.hasFieldErrors(name)]
        <ul class="error">
            [#list bindStatus.getFieldErrors(name) as error]
                <li>${error.defaultMessage}</li>
            [/#list]
        </ul>
    [/#if]
[/#macro]

[#macro attrs attributes]
    [#list attributes as name, value]
        ${name}="${value}"
    [/#list]
[/#macro]
