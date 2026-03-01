\version "2.24.4"
\header {
  title = "いとしあの星"
  composer = "服部良一"
  poet = "サトウハチロー"
}

global = {
  \key d \major
  \numericTimeSignature
  \time 2/4
}

var = {
  b4 b8. b16 |
  a8 b4. |
  d'16 b16 a8 fis8 fis8 |
  fis2 |
}

right = \fixed c' {
  \global
  \var
  \var \break
  e4 e8. e16 |
  d8 e4. |
  fis16 e d8 b,8 b, |
  b,2 |
  b,8 cis d b, |
  fis2 |
  e8 fis a e16 cis |
  fis2 | \break
}

left = \fixed c {
  \global
  \clef bass
}

\score {
  \new PianoStaff <<
    \new Staff = "RH" \right
    \new Staff = "LH" \left
  >>
  \layout {
    indent = 0\mm
  }
}
