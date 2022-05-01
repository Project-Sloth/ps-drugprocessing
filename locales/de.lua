local Translations = {
    error = {
        no_chemicals = "Dir fehlen Chemikalien",
    },
    success = {

    },
    info = {

    },
    progressbar = {
        processing = "Verarbeite...",
        pickup_chemicals = "Hebe Chemikalien auf...",
    },
    items = {
        hydrochloric_acid = "Salzsäure",
        sodium_hydroxide = "Natriumhydroxid",
        sulfuric_acid = "Schwefelsäure",
        lsa = "LSA",
    },
    menu = {
        chemMenuHeader = "Chemie Menü",
        chemicals = "x1 Chemikalien",
        close = "Schließen",
        closetxt = "Menü schließen",
    },
    target = {

    },
}
--Lang:t("error.has_no_drugs")
Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})