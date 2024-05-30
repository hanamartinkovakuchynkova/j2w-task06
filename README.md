# Úkol 6 – Vizitky 3.0

Aplikaci pro zobrazování vizitek upravíme tak, aby údaje o vizitkách měla uložené v databázi. Údaje se tak (konečně!) nebudou ztrácet při restartu aplikace.
Jako výchozí repository použij toto repository, je zde nakonfigurovaná databáze. Pokud sis v předchozích úkolech s vizitkami upravovala vzhled stránky,
můžeš úpravené styly a stránky použít i zde.

Aplikace bude na úvodní stránce zobrazovat seznam vizitek (šablona `seznam.ftlh`). Po kliknutí na vizitku se zobrazí její detail – stránka s jednou vizitkou,
pod vizitkou bude mapa (šablona `vizitka.ftlh`). Na titulní stránce je také tlačítko pro přidání vizitky. To zobrazí formulář pro přidání vizitky – šablona
`formular.ftlh`. Úpravu a mazání vizitky implementovat nemusíš, ale můžeš to udělat jako bonusový úkol.

Repository obsahuje skripty pro vytvoření databáze a vzorové šablony stránek. V Java kódu obsahuje jenom třídu `Application` – všechny ostatní třídy musíš
vytvořit ty. 

Databáze obsahuje jednu tabulku pojmenovanou `vizitka`. Tabulka obsahuje následující sloupečky:

* `id` – číselný identifikátor vizitky, primární klíč – v Javě pro něj použij typ `Integer`
* `cele_jmeno` – nezapomeň, že v entitě bude property pojmenovaná `celeJmeno`
* `firma`
* `ulice`
* `obec`
* `psc` – PSČ je v databázi uložené jako text o délce 5 znaků
* `email`
* `telefon`
* `web`

Všechny textové řetězce mají maximální délku 100 znaků, s výjimkou PSČ, které má vždy 5 znaků, a s výjimkou telefonního čísla, které má maximálně 20 znaků.
Údaje `email`, `telefon` a `web` jsou v databázi nepovinné, ostatní údaje jsou povinné. V entitě bude také read-only property `celaAdresa`, která poskládá adresu
z ulice, PSČ a obce. tato property se použije v detailu vizitky pro zobrazení mapy.

Pokud se chce do tabulky v databázi podívat, spusť jednou aplikaci, aby se databáze vytvořila. Připojovací URL, které se zadává při konfiguraci panelu Database
v IntelliJ Idea, najdeš v souboru `src/main/resources/application.yaml`.

Kód, který v controlleru zajistí, aby se prázdné stringy převedly na `null`, je zde:
```java
@InitBinder
public void nullStringBinding(WebDataBinder binder) {
  binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
}
```
1. Použij toto repository jako šablonu (Use this template), ze které si vytvoříš repository ve svém účtu na GitHubu.
1. Naklonuj si repository **ze svého účtu** na GitHubu na lokální počítač.
1. Spusť si naklonovanou aplikaci, aby se vytvotřila databáze. V prohlížeči se na stránce [http://localhost:8080/](http://localhost:8080/) zatím bude zobrazovat
   jen chyba, v aplikaci není žádný controller.
1. Zprovozni si panel Database v IntelliJ Idea, ať si můžeš ověřit, co je v databázi. Připojovací URL, které se zadává při konfiguraci panelu Database
   v IntelliJ Idea, najdeš v souboru `src/main/resources/application.yaml`. Na panelu se vytváří nový *Data Source*, databáze je *H2*.
1. Vytvoři si controller (nezapomeň na odpovídající anotaci třídy), která bude odpovídat na požadavky `GET` na URL `/`. Metoda zobrazí view `seznam`, zatím
   bez dat. Ověř si, že se v prohlížeči zobrazí stránka s jednou vizitkou a jednou prázdnou vizitkou, která funguje jako tlačítko pro přidání.
1. Vytvoř entitu `Vizitka`, nezapomeň na správnou anotaci třídy. Přidej fieldy na základě popisu tabulky výše a z fieldů vygeneruj properties. Vlastní
   konstruktor není potřeba (Java automaticky vytvoří bezparametrický konstruktor, který nám stačí). Nezapomeň field `id` označit anotacemi – jde o databázový
   identifikátor a databáze ho má generovat automaticky.
1. Vytvoř respository pro přístup k databázové tabulce s vizitkami. Na jménu repository nezáleží, nezapomeň však na správnou anotaci. Repository nebude třída
   (`class`), ale rozhraní (`interface`) a rozšiřuje (`extends`) rozhraní `CrudRepository`. Při rozšiřování `CrudRepository` je potřeba uvést typ entity (`Vizitka`)
   a typ primárního klíče (databázového identifikátoru) `Integer`.
1. Uprav controller tak, že bude mít field pro repository. Vytvoř pro controller konstruktor, který dostane repository jako vstupí parametr a uloží si ho do fieldu,
   aby bylo možné repository později v controlleru používat.
1. Uprav metodu controlleru, která zobrazuje seznam vizitek, aby z repository získala seznam vizitek voláním `findAll()`. Seznam vizitek vlož do modelu pod
   nějakým klíčem, třeba `seznam`.
1. Uprav šablonu `seznam.ftlh` tak, aby pomocí `[#list]` procházela seznam vizitek a vypisovala je na stránku. Teď si zase můžeš v prohlížeči zkontrolovat, že
   se úvodní stránka zobrazuje správně a už na ní není jedna vizitka, ale všechny vizitky zadané v databázi. Můžeš si otevřít tabulku vizitka v IntelliJ Idea a
   přidat do ní nový záznam nebo záznam upravit a ověřit, že se v prohlížeči po obnově stránky data změní.
1. Zkontroluj, že správně fungují odkaz na úvodní stránce – první vizitka by měla odkazovat na adresu `http://localhost:8080/1`, druhá na `http://localhost:8080/2`.
   Čísla za lomítkem jsou ID databázového záznamum tj. nemusí začínat jedničkou.
1. Zprovozni metodu controlleru, která bude reagovat na požadavky metodou `GET`, které budou mít v URL hned za lomítkem číslo. Číslo bude předáno jako parametr
   dovnitř metody. Na základě tohoto ID načti pomocí repository z databáze jeden záznam s odpovídajícím ID. Dostaneš na výstupu typ `Optional<Vizitka>`. Ověříš,
   zda je v `Optional` přítomná hodnota. Pokud ano, vložíš ji do modelu a zobrazíš pomocí šablony `vizitka.ftlh`. Pokud v `Optional` nebudou data přítomná
   (vizitka s daným ID neexistuje), ukončíš metodu voláním `return` s návratovým kódem, který prohlížeči signalizuje stav `404 Not found` – stránka nenalezena.
   Použij k tomu tento kód:
   ```java
   return ResponseEntity.notFound().build();
   ```
1. Uprav šablou `vizitka.ftlh`, aby zobrazovala data z modelu. Pro zobrazení mapy použij property `celaAdresa`. HTML kód pro zobrazení adresy bude vypadat takto
   (předpokládám, že údaje o vizitce jsou v modelu uložené pod klíčem `vizitka`):
   ```html
   <iframe style="border:none" src="https://frame.mapy.cz/?q=${vizitka.celaAdresa?url}" width="100%" height="100%" frameborder="0"></iframe>
   ```
1. Vyzkoušej v prohlížeči, že se správně zobrazují detaily vizitky. A také že se zobrazí v prohlížeči chyba (je to stránka zobrazená přímo prohlížečem), pokud
   v adrese zadáš nějaké neexistující ID.   
1. Do controlleru přidej metodu, která bude reagovat na `GET` požadavky na adrese `/nova`. Metoda jen zobrazí šablonu `formular.ftlh`. Uprav formulář tak,
   aby odesílal data metodou `POST` na adresu `/nova`. Vyzkoušej v prohlížeči, že funguje odkaz na přidání vizitky na úvodní stránce.
1. Do controlleru přidej POST metodu, která bude reagovat na `POST` požadavky na adrese `/nova`. Jako parametr bude přijímat entitu `Vizitka`, použijeme ji i
   pro přenos dat z formuláře. Použij metodu `save()` repository pro uložení vizitky. Po uložení vizitky přesměruj uživatele na úvodní stránku. Vyzkoušej
   v prohlížeči, že funguje přidání vizitky.
1. **Bonus 1** Formulář pro přidání vizitky má už na sobě validace. To jsou však jen doporučení pro prohlížeč, uživatel je může obejít – může si např.
   v prohlížeči stránku upravit tak, že validace odstraní. V našem případě by nanejvýš poškodil své vlastní vizitky, navíc povinnost údajů hlídá i databáze
   (ta ale třeba pustí prázdné jméno – kontroluje jenom zda není `null`). V reálné aplikaci je tedy vždy potřeba kontrolovat vstup uživatele i na serveru. Můžeš
   tedy jako bonus doplnit do entity i validační anotace, přidat validaci do controlleru a podle výsledku validace zjišťovat, zda znovu zobrazit formulář, nebo
   zda je validace bez chyb a je možné záznam uložit do databáze. Pro validaci PSČ můžeš použít anotaci `@Pattern(regexp = "\\d{5}")` – uvedený regulární výraz
   kontroluje, že text obsahuje přesně pět číslic. Tip – pokud nechceš odebírat všechny klientské validace z formuláře, stačí na formulář (HTML element `<form>`)
   přidat prázdný atribut `novalidate`. Tím se validace v prohlížeči vypnou.
1. **Bonus 2** Můžeš na stránku s detailem přidat tlačítko pro mazání vizitky, případně pro její úpravu. Tlačítko pro úpravu by uživatele přesměrovalo na stránku
   s formulářem, kde budou předvyplněné současné údaje. Po uložení přesměruj uživatele zpět na stránku s detailem vizitky, kde už uživatel uvidí změněné údaje.
   Po smazání vizitky uživatele přesměruj na úvodní stránku. V controlleru přidej metody, které zobrazí formulář pro editaci (metodou `GET`), uloží upravenou
   vizitku (metoda bude volána metodou `POST`) a metodu, která smaže vizitku určenou ID (také metoda `POST`). Metoda pro uložení vizitky by opět měla validovat
   vstupní data a zobrazit znovu formulář s validačními chybami, pokud je nějaký údaj špatně nebo chybí.
1. Zkontroluj, zda vše funguje.
1. *Commitni* a *pushnni* změny (výsledný kód) do svého repository na GitHubu.
1. Vlož odkaz na své repository jako řešení úkolu na portálu [Moje Czechitas](https://moje.czechitas.cz).

## Odkazy

* odkaz na stránku [Lekce 8](https://java.czechitas.cz/2024-jaro/java-2-online/lekce-8.html)
* Java SE 21 [Javadoc](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/) – dokumentace všech tříd, které jsou součástí základní Javy ve verzi 21.
* Dokumentace [Spring Boot](https://spring.io/projects/spring-boot#learn) – odsud je anotace `@SpringBootApplication` a třída `SpringApplication`.
* Dokumentace [Spring Framework](https://spring.io/projects/spring-framework#learn) – odsud jsou anotace `@Controller`, `@GetRequest` a třída `ModelAndView`.
* Dokumentace [Freemarker](https://freemarker.apache.org/docs/) – šablonovací systém pro HTML použitý v projektu.
* Dokumentace [HTML formulářů](https://developer.mozilla.org/en-US/docs/Learn/Forms)
* [Bootstrap](https://getbootstrap.com) – jeden z CSS frameworků
* [Bootstrap Icons](https://icons.getbootstrap.com) – sada ikon pro použití na webu
* [Unsplash](https://unsplash.com) – obrázky a fotografie k použití zdarma
