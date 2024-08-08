
-- default keywords

-- PERF: fully optimized
-- HACK: hmmm, this looks a bit funky
-- TODO: what else?
-- NOTE: adding a note
-- FIX: this needs fixing
-- FIXME: this too
-- BUG: and this
-- FIXIT: and that
-- ISSUE: don't forget this
-- WARNING: ???

-- WARN:
-- XXX:
-- OPTIM:
-- PERFORMANCE:
-- OPTIMIZE:
-- INFO:
-- TEST:
-- TESTING:
-- PASSED:
-- FAILED:

-- custom keywords

-- WIP:
-- WORK_IN_PROGRESS:
-- IN_PROGRESS:
-- COOKING:
-- BAKING:
-- NOT_FULLY_COOKED:
-- NOT_FULLY_BAKED:
-- DONE: 
-- FINISHED: 
-- COMPLETE: 
-- COMPLETED: 
-- COOKED:
-- CITE: citation needed
-- ENDCITE: end of copied code
-- REF: loosly following this
-- ENDREF: no longer referencing
-- LINK: here's some further reading
-- ENDLINK: the docs can't help you now
-- SEE: some article or something
-- ENDSEE: this is no longer related
-- WHAT:
-- WTF:
-- HUH:
-- HMMM:
-- UMMM:
-- UHHH:
-- OHHH:
-- FUCK:
-- FRICK:
-- SHIT:
-- SHOOT:
-- OOPS:
-- WHOOPS:
-- OOPSIE:
-- WHOOPSIE:
-- OOPSIE_DAISY:
-- WHOOPSIE_DAISY:
-- SORRY:
-- BROKE:
-- BROKEN:
-- RIP:
-- OOF:
-- END:

-- color keywords: "error", "warning", "info", "hint", "default", "test",

local opts = {
    keywords = {
        WIP = { icon = "⏲ ", color = "warning", alt = { "WORK_IN_PROGRESS", "IN_PROGRESS", "COOKING", "BAKING", "NOT_FULLY_COOKED", "NOT_FULLY_BAKED" } },
        DONE = { icon = " ", color = "info", alt = { "FINISHED", "COMPLETE", "COMPLETED", "COOKED", "BAKED", } },
        CITE = { icon = "Ⓒ ", color = "hint", alt = { "ENDCITE", "REF", "ENDREF", "LINK", "ENDLINK", "SEE", "ENDSEE", } },
        WHAT = { icon = "", color = "error", alt = { "WTF", "HUH", "HMMM", "UMMM", "UHHH", "OHHH",
        "FUCK", "FRICK", "SHIT", "SHOOT", "OOPS", "WHOOPS", "OOPSIE", "WHOOPSIE", "OOPSIE_DAISY", "WHOOPSIE_DAISY",
        "SORRY", "BROKE", "BROKEN", "RIP", "OOF", "END" } },
    },
    highlight = { multiline = false },
}

return opts

