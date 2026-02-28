\version "2.24.4"
\header {
  title = "南洋航路"
  subtitle = "(ラバウル小唄)"
  composer = "島口駒夫"
  poet = "若杉雄三郎"
}

global = {
  \key c \major
  \numericTimeSignature
  \time 4/4
}

right = \fixed c' {
  \global
  c2 d4. e8 |
  g8 g4 a8 g2 |
  c'8. c'16 c'8. c'16 a8. g16 a4 |
  g1 | \break

  e2 d8. c16 d8. e16 |
  g4 g8. c'16 a4 g4 |
  e8. e16 e8. e16 d8. c16 d4 |
  c1 | \break

  \fixed c'' {
    c4. d8 e4 e4 |
    d8. e16 d8. c16 a,8. g,16 e,4 |
  }
  g8. g16 g8. a16 c'4 a8. g16 |
  g1 | \break

  c'2 a8. g16 a8. g16 |
  e4 g8. a16 c'4 e' |
  d'4 c'8. a16 g4 a8. c'16 |
  c'1 |
}

var = {
  c4 g e g |
  g,4 e d c |
  a,4 d c a, |
  c4 e d c | \break
}

left = \fixed c {
  \global
  \clef bass
  \var
  \var
  \var
  \var
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
