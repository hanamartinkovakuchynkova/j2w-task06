[#ftl]
[@c.page]
    <div class="detail">
        <div class="vizitka">
            <div class="jmeno">${vizitky.celeJmeno}</div>
            <div class="firma">${vizitky.firma}</div>
            <div class="udaje">
                <div class="adresa">
                    <div>${vizitky.ulice}</div>
                    <div>${vizitky.psc}</div>
                    <div>${vizitky.obec}</div>
                </div>
                <div class="kontakty">
                    [#if vizitky.email??]
                        <div><i class="las la-at"></i> <span>${vizitky.email}</span></div>
                    [/#if]
                    [#if vizitky.telefon??]
                        <div><i class="las la-phone-alt"></i> <span>${vizitky.telefon}</span></div>
                    [/#if]
                    <div><i class="las la-globe"></i> <span>${vizitky.web}</span></div>
                </div>
            </div>
        </div>

        <div class="mapa">
            <iframe style="border:none" src="https://frame.mapy.cz/?q=${vizitky.celaAdresa()?url("UTF-8")}" width="100%" height="100%"
                    frameborder="0"></iframe>
        </div>

        [@c.back /]
    </div>
[/@c.page]