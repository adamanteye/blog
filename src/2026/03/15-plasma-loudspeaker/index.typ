#import "/page.typ": *
#import "meta.typ": desc, title
#show: conf.with(title: title, desc: desc)

= Introduction

A plasma loudspeaker converts electrical signals into acoustic pressure waves
using a gaseous discharge@professor_hafner_corona_2015 as the transducer. Common
types of plasma loudspeakers include RF corona, DC corona and DC glow. Using a
glow discharge has advantages rather than other types of
discharges@mazzola_modeling_1987.

= Model

The acoustic field in a plasma loudspeaker can be described as an ordinary
pressure wave in a neutral ideal gas driven by discharge-induced source terms.
Bastien's formulation emphasizes the general source structure: a heat term and a
force term. Mazzola and Molen show that, for the DC glow loudspeaker, the
dominant mechanism is thermal: current modulation changes the plasma
temperature, temperature modulation causes pressure modulation through the
ideal-gas relation, and efficient sound radiation occurs only when the plasma
becomes sufficiently adiabatic relative to the modulation
frequency@bastien_acoustics_1987.

#bibliography("main.bib")
