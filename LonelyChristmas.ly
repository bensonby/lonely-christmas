\version "2.18.2"
#(set-global-staff-size 15)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  http://lsr.di.unimi.it/LSR/Item?id=445

%LSR by Jay Anderson.
%modyfied by Simon Albrecht on March 2014.
%=> http://lilypond.1069038.n5.nabble.com/LSR-445-error-td160662.html

#(define (octave-up m t)
 (let* ((octave (1- t))
      (new-note (ly:music-deep-copy m))
      (new-pitch (ly:make-pitch
        octave
        (ly:pitch-notename (ly:music-property m 'pitch))
        (ly:pitch-alteration (ly:music-property m 'pitch)))))
  (set! (ly:music-property new-note 'pitch) new-pitch)
  new-note))

#(define (octavize-chord elements t)
 (cond ((null? elements) elements)
     ((eq? (ly:music-property (car elements) 'name) 'NoteEvent)
       (cons (car elements)
             (cons (octave-up (car elements) t)
                   (octavize-chord (cdr elements) t))))
     (else (cons (car elements) (octavize-chord (cdr elements ) t)))))

#(define (octavize music t)
 (if (eq? (ly:music-property music 'name) 'EventChord)
       (ly:music-set-property! music 'elements (octavize-chord
(ly:music-property music 'elements) t)))
 music)

makeOctaves = #(define-music-function (parser location arg mus) (integer? ly:music?)
 (music-map (lambda (x) (octavize x arg)) (event-chord-wrap! mus)))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\header {
  title = "陳奕迅 - Lonely Christmas (Jazz)"
  subtitle = "For female voice and piano accompaniment"
  arranger = "Arranged by Benson"
}

upper-intro = \relative c'' {
  \cadenzaOn
  <e g b>1.\arpeggio
  \tiny
  << {
    \tiny
    \stemNeutral
    \appoggiatura <d' g>16 b'16[\( c d c b a] b[ c b a b a g e]
    \acciaccatura d16 ees8->[ d c d c \acciaccatura gis16 a8 c a]
    \bar "!"
    \stemUp
    e2.\)
  } \\ {
    \stemDown
    \tiny
    s4.
    s2
    s1
    r8
    c16[\( d e g a c]
    d[ e g a \ottava #1 d e]
    a4.\)
  } >>
  \stemNeutral
  \bar "!"
  \appoggiatura { f16 g f e }
  f4.\( g,8[ e' e]
  f,[ d' d c c d]
  \bar "!"
  <aes ees'>8\arpeggio[ d d c c bes] \ottava #0 bes[ aes aes g g f]
  \bar "!"
  \appoggiatura g,16 g'1.\)
  \bar "|"
  \normalsize
  \cadenzaOff
}

lower-intro = \relative c' {
  \cadenzaOn
  <c g'>1.\arpeggio
  \tiny
  s4.
  s2
  s1
  f2.
  s2
  d8[\( a' \clef treble e'~] e4. a2.\)
  f,4\( f' aes~\) aes2.
  r8
  d,8[\( d' g a b \ottava #1 d]
  g4.\)
  \ottava #0
  s4
  \normalsize
  \cadenzaOff
}

upper-prelude = \relative c {
  << { \stemNeutral <a''' e'>4\( <d, a' e'>8 gis a c <d, g b e>4 <e bes' cis f>8~ q e' b
  d4 <e, gis d'>8~ q c' b \stemUp c2.\) } \\ { s1. s2. \stemDown r8 dis, fis a bes b } >>
  <e, g c>4\( <e aes c>8~ q c f <f aes c>4 <f aes d>8~ q4 b8
  <ees, c'>4.\) g4\( f8 <a, b e>4.~ <a b d>\)
}

lower-prelude = \relative c {
  \clef bass
  f4 bes8 bes,4. e4 a,8 a' g,4 r4 fis8~ fis4. b2.
  a4. aes4. g2. fis2. f
}

lower-melodya = \relative c {
  e2. d c bes4. aes
  ees'2. d des c4. bes
  g'2. fis f4. e dis2.
  d2. d,4-- e8~-- e fis4-- g2.~-- g2.
}

upper-melodya = \relative c' {
  \clef treble
  <g' a c>2. <f a c> <e g b> <c f a>4\(^\< a'8\! <c, ees g c>8^\> bes' aes\!
  <c, d g>2.\) <e fis cis'> <e gis b>4. gis8\(^\< a b\! <f g c>8^\> bes aes\! g4.\)
  <f bes d>2.\( <a cis e>4. f'8 \acciaccatura dis16 e8 d <d, g a c>4. <d g b> <cis fis a>2.\)
  <c f>8\( \acciaccatura gis'16 a8 c a4.\) <f aes c>4-- <f d'>8~-- q <c' e>4-- <f, aes d>4.--
  f16\( g aes bes c aes bes c d e f fis g4.\)
}

lower-melodya-dash = \relative c {
  e4.~ e4 ees8~ ees2.
  r4 <d a'>8~-- q4 aes8 g2.
  c8~ <c b'>4~ q4. cis4 d8~ d4. dis4 << { s8 r8 b' e~ e2. } \\ { e,8~ e4.~ e2. } >>
  g2. fis f4. e r4 <dis dis,>8~-- q4.
  d2. d,4-- e8~-- e fis4-- g2.~-- g4. g8 a b
}

upper-melodya-dash = \relative c' {
  <e g a d>8 e g <a d> g <ees g a d>~ q ees g a d4
  r4 <c, aes'>8~-- q8 c4 r4 c8\( <f aes d>4.\)
  r4 <a c>8~ <aes c>4. <g b>4 <g b f' g>8~ q8 d8 g <g b f'>4 <gis b e>8~ q4. r8 d'\( f d b aes\)
  <g bes f'>2.\( <a cis e>4. e'8 f \acciaccatura dis16 e8 <d, g a c>4. <d g b>\) d'8\( \acciaccatura ais16 b8 <cis, fis a>8~\)-- q4.
  <c f>8\( \acciaccatura gis'16 a8 c a4.\) <f aes c>4-- <f d'>8~-- q <c' e>4-- <f, aes d>4.~-- q4
  c'16\( f aes d g f ees des c bes aes g f ees\)
}

lower-melodyb = \relative c, {
  <c c'>2.~ q
  <a a'>~ q
  f''4. g4 a8~-- a2.
  d,4-- e8~-- e fis4-- g2.--
  <c,, c'>2.~ q
  <a a'>~ q
  f''4. g4 a8~-- a a c \change Staff = "right" e a c
  \change Staff = "left"
  d,,4-- e8~-- e fis4-- g2.-- c,2.~ c
}

upper-melodyb = \relative c {
  % \clef bass % depending on transpoing interval
  <e' g a d>4.
  % \clef treble % depending on transpoing interval
  <e' g a d>4. e'8\( g a \acciaccatura ais16 b4.\)
  % \clef bass % depending on transpoing interval
  <e,,, g a d>4.
  % \clef treble % depending on transpoing interval
  <e' g a d>4. g'8\( a b \acciaccatura cis16 d4.\)
  <f,, a c d>4. d8~ <d e gis b>8 <e g a c>8~-- q2.
  <d f aes c>4-- <c e ges bes>8~-- q <c ees a>4-- <c d aes'>4.~-- <c d g>
  % \clef bass % depending on transpoing interval
  <e, g a d>4.
  % \clef treble % depending on transpoing interval
  <e' g a d>4. e'8\( g a \acciaccatura ais16 b4.\)
  % \clef bass % depending on transpoing interval
  <e,,, g a d>4.
  % \clef treble % depending on transpoing interval
  <e' g a d>4. g'8\( a b \acciaccatura cis16 d4.\)
  <f,, a c d>4. d8~ <d e gis b>8 <e g a c>8~-- q2.
  <d f aes c>4-- <c e ges bes>8~-- q <c ees a>4-- <c d aes'>2.--
  <e, g b d>8 e g <b d> e, g
}

upper-melodyb-end-a = \relative c' {
  <e g a c>8 b' <e, g b d>8~ q b' g
}

upper-melodyb-before-melodyc = \relative c'' {
  dis8 e \acciaccatura f16 fis8 g a b
}

upper-episode = \relative c'' {
  dis8\( e g g e g
  a4 c8~ c a c
  d4 d8~ d c d
  <e g,> g b g e d
  <d ees,>4-- <c d, e>8~\)-- q g\( g
  a f c'~ c a c
  g' a d,~ d c d
  <c g d>4.\) e,8 cis a <aes c f>4. <aes c g'> 
}

upper-episode-jazz = \relative c'' {
  dis8\( e \acciaccatura f16 fis8 g bes g
  gis8 a16 b c8~ c8 a c
  d4 \appoggiatura { f16 e } d8~ d c d
  <dis g,>16 e fis-1 g-3 a-4 b-5 g8-3 e-1 d-3
  <d-3 ees,>8-- \tuplet 3/2 8 { e16-5 ees-4 d-3 } <c-2 d, e>8~\)-- q g\( g
  gis8 a16 b c8~ c8 e,16 gis c e
  gis8 a d,~ d c d
  <c g d>4.\) e,8 cis a <aes c f>4. <aes c g'> 
}

lower-episode = \relative c {
  <f e'>4. <a' c>
  <bes, d aes'> <c' d>
  a,8 e' g d'4.
  <aes, g' bes>4-- <g g'>8~-- q4.
  fis8 c' a' e'4.
  <f,, ees'>4. <aes' c>
  <e, d'>2.
  d4.
  g
}

lower-melodyc = \relative c' {
  <fis e'>8-.-> q-. q-. q-.-> q-. q-.
  <f e'>8-.-> q-. q-. q-.-> q-. q-.
  <e d'>8-.-> q-. q-. q-.-> q-. q-.
  <a, bes'>8-.-> q-. q-. <aes bes'>-.-> q-. q-.
  <g a'>-.-> q-. q-. q-.-> q-. q-.
  <g aes'>-.-> q-. q-. <g g'>-.-> q-. q-.
  <c, c'>4->--\sustainOn <c' c'>8~->-- q <c, c'>-> <b b'>->\sustainOff\sustainOn
  <a a'>2.->--\sustainOff\sustainOn

  <fis'' e'>8-.->\sustainOff q-. q-. q-.-> q-. q-.
  <f e'>8-.-> q-. q-. q-.-> q-. q-.
  <e d'>8-.-> q-. q-. q-.-> q-. q-.
  <a, bes'>8-.-> q-. q-. <aes bes'>-.-> q-. q-.
  <d c'>-.-> q-. q-. q-.-> q-. q-.
  <e d'>-.-> q-. q-. q-.-> q-. q-.
  <f, f'>4->-- <g g'>8~->-- q <aes aes'>4->--
  <bes bes'>4.->-- <aes aes'>->--
}

upper-melodyc = \relative c''' {
  <a c>8-.-> q-. q-. q-.-> q-. q-.
  <g aes d>8-.-> q-. q-. q-.-> q-. q-.
  <g b d>-.-> q-. q-. <fis bes d>-.-> q-. q-.
  <e g bes d>-.-> q-. <ees g bes c>-.-> q-. q-. q-.
  <f a c>-.-> q-. q-. <f a cis>-.-> q-. q-.
  <f g c>-.-> q-. q-. <f aes d>-.-> q-. q-.
  <e g b c e>-> q q q q q
  <e g bes cis e>-> q q q q q

  <a c>8-.-> q-. q-. q-.-> q-. q-.
  <g aes d>8-.-> q-. q-. q-.-> q-. q-.
  <g b d>-.-> q-. q-. <fis bes d>-.-> q-. q-.
  <e g bes d>-.-> q-. <ees g bes c>-. q-.-> q-. q-.
  <f a c>-.-> q-. q-. q-.-> q-. q-.
  <g b>-.-> q-. q-. q-.-> q-. q-.
  <c, ees aes c> q <cis e bes'> q <b d f aes> <ces ees ges aes>
  <aes c d g>4.->-- <a c d fis>->--
}

upper-ending = \relative c'' {
  a8\( c d e g a
  <f c'>4.\) <e bes'> <ees a> <d aes'>
  << {
    \tuplet 2/3 { e'8\( e } e4.
    \tuplet 2/3 { e8 e } e4.
    \tuplet 2/3 4. {
      \set Score.tempoHideNote = ##t
      \tempo 4. = 74
      e8
      \tempo 4. = 66
      g
      \tempo 4. = 54
      c,
      \tempo 4. = 40
      d
      \tempo 4. = 32
    } e2.\)
  } \\ {
    <g, b>4. <fis a> <f aes> <e g>
    <f b>
    \omit TupletNumber
    \tuplet 2/3 { <d f>8 <f aes> } <g b>2.
  } >>
}

lower-ending = \relative c' {
  d4. e fis g c b bes a aes g c,2.
}

upper-midi = \relative c' {
  \set Staff.pedalSustainStyle = #'bracket
  \key c \major
  \clef treble
  \tempo 4. = 78
  \time 12/8
  \upper-intro
  \upper-prelude
  \upper-melodya
  \upper-melodya-dash
  \upper-melodyb
  \upper-episode-jazz
  \upper-melodya-dash
  \upper-melodyb
  \upper-melodyb-before-melodyc
  \upper-melodyc
  \key des \major
  \transpose c des {
    \upper-melodyb
    \upper-melodyb-end-a
    \upper-melodyb
    \upper-ending
  }
  \bar "|."
}

upper-print = \relative c' {
  \set Staff.pedalSustainStyle = #'bracket
  \key c \major
  \clef treble
  \tempo 4. = 78
  \time 12/8
  \upper-intro
  \upper-prelude
  \upper-melodya
  \upper-melodya-dash
  \upper-melodyb
  \upper-episode-jazz
  \upper-melodya-dash
  \upper-melodyb
  \upper-melodyb-before-melodyc
  \upper-melodyc
  \key des \major
  \transpose c des {
    \upper-melodyb
    \upper-melodyb-end-a
    \upper-melodyb
    \upper-ending
  }
  \bar "|."
}

lower-midi = \relative c {
  \set Staff.pedalSustainStyle = #'bracket
  \key c \major
  \clef bass
  \time 12/8
  \lower-intro
  \lower-prelude
  \lower-melodya
  \lower-melodya-dash
  \lower-melodyb
  \lower-episode
  \lower-melodya-dash
  \lower-melodyb
  \lower-melodyc
  \key des \major
  \transpose c des {
    \lower-melodyb
    \lower-melodyb
    \lower-ending
  }
  \bar "|."
}

lower-print = \relative c {
  \set Staff.pedalSustainStyle = #'bracket
  \key c \major
  \clef bass
  \time 12/8
  \lower-intro
  \lower-prelude
  \lower-melodya
  \lower-melodya-dash
  \lower-melodyb
  \lower-episode
  \lower-melodya-dash
  \lower-melodyb
  \lower-melodyc
  \key des \major
  \transpose c des {
    \lower-melodyb
    \lower-melodyb
    \lower-ending
  }
  \bar "|."
}

dynamics = {
  #(skip-of-length upper-intro)
  s1.\mf
  s1.*2
  s4. s4.\> s4. s4.\!
  s1.\mp
  s1.*3
  s1.\mf
  s1.*19
  s8 s4\p s4. s2.\mf
  s1.*21
  s1.\mf
  s1.
  s1.-"cresc."
  s4.\ff s4 s8
  s2.
  s1.\f
  s1.
  s1.-"cresc."
  s1.\ff
  s1.\f
  s1.*16
  s8 s4\mp s4. s2.
  s1.*2
  s4.-"rit."
}

guitarchords = \chordmode {
}

lyricsmain = \lyricmode {
  誰 又 騎 著 那 鹿 車 飛 過
  忘 掉 投 下 那 禮 物 給 我
  凝 視 那 燈 飾 只 有 今 晚 最 光 最 亮
  卻 照 亮 我 的 寂 寞

  誰 又 能 善 心 親 一 親 我
  由 唇 上 來 驗 證 我 幸 福 過
  頭 上 那 飄 雪 想 要 棲 息 我 肩 膊 上
  到 最 後 也 別 去 麼

  Mer -- ry, Mer -- ry Christ -- mas
  Lone -- ly, Lone -- ly Christ -- mas
  人 浪 中 想 真 心 告 白
  但 你 只 想 聽 聽 笑 話
  Lone -- ly, Lone -- ly Christ -- mas
  Mer -- ry, Mer -- ry Christ -- mas
  明 日 燈 飾 必 須 拆 下
  換 到 歡 呼 聲 不 過 一 剎

  誰 又 能 善 心 親 一 親 我
  由 唇 上 來 驗 證 我 幸 福 過
  頭 上 那 飄 雪 想 要 棲 息 我 肩 膊 上
  到 最 後 也 別 去 麼

  Mer -- ry, Mer -- ry Christ -- mas
  Lone -- ly, Lone -- ly Christ -- mas
  人 浪 中 想 真 心 告 白
  但 你 只 想 聽 聽 笑 話
  Lone -- ly, Lone -- ly Christ -- mas
  Mer -- ry, Mer -- ry Christ -- mas
  明 日 燈 飾 必 須 拆 下
  換 到 歡 呼 聲 不 過 一 剎

  明 晨 遇 到 亦 記 不 到 和 誰 在 醉 酒 中 偷 偷 擁 抱
  仍 然 在 傻 笑 但 你 哪 知 道 我 想 哭
  和 誰 撞 到 亦 怕 生 保 寧 願 在 醉 酒 中 辛 苦 嘔 吐
  仍 然 在 頭 痛 合 唱 的 詩 歌 聽 不 到

  Mer -- ry, Mer -- ry Christ -- mas
  Lone -- ly, Lone -- ly Christ -- mas
  人 浪 中 想 真 心 告 白
  但 你 只 想 聽 聽 笑 話
  Lone -- ly, Lone -- ly Christ -- mas
  Mer -- ry, Mer -- ry Christ -- mas
  明 日 燈 飾 必 須 拆 下
  換 到 歡 呼 聲 不 過 一 剎

  Mer -- ry, Mer -- ry Christ -- mas
  Lone -- ly, Lone -- ly Christ -- mas
  人 浪 中 想 真 心 告 白
  但 你 只 想 聽 聽 笑 話
  Lone -- ly, Lone -- ly Christ -- mas
  Mer -- ry, Mer -- ry Christ -- mas
  明 日 燈 飾 必 須 拆 下
  換 到 歡 呼 聲 不 過 一 剎

  換 到 歡 呼 聲 不 過 一 剎
}

melodya = \relative c' {
  r4. c8 d c e4 g8 r g f e4 c8~ c4 r8 r4. r4.
  r4. c8 d c e4 g8 r g e b'4 g8~ g4 r8 r4. r4.
  r4. f8 g aes c4 aes8~ aes g f g4 e8 r d e d4 cis8~ cis4 r8
  r4. f8 f e f4 g8~ g8 e4 d2. r4. r4.
}

melodya-dash = \relative c' {
  r4. c8 d c e4 g8 r g f e4 c8~ c4 r8 r4. r4.
  r4 c8 c d c e4 g8 r g e b'4 g8~ g4 r8 r4. r4.
  r4. f8 g aes c4 aes8~ aes g f g4 e8 r d e d4 cis8~ cis4 r8
  r4. f8 f e f4 e8~ e8 f4 g2. r4. r4.
}

melodyb = \relative c' {
  e4 g8~ g e g d'4. e
  e,4 g8~ g e g d'4. e8 d e
  f4 f8 e4 e8 c4 a8 r
  a c g'4 g8 f4 f8 c4 d8~ d4 r8
  e,4 g8~ g e g d'4. e
  e,4 g8~ g e g d'4. e8 d e
  f4 f8 e4 e8 c4 a8 r
  a c g'4 g8 f4 f8 c4. d c4. r4.
}

melodyc = \relative c'' {
  r4. r8 g g
  a4 c8~ c a c d4 d8 r c d e g b g e d d4 c8 r g g
  a f c' r a c g' a d, r c d e4. r4. r4. r8 g, g
  a4 c8~ c a c d4 d8 r c d e g b g e d d4 c8 r g g
  a f c' r a c g' e d r c d c4. r4. r2.
}

melody-last = \relative c'' {
  r4. r8
  a c g'4 g8 f4 f8 c4. d c4. r4.
}

melody = \relative c' {
  \key c \major
  \clef treble
  \time 12/8
  #(skip-of-length upper-intro)
  R1.*4
  \melodya
  \melodya-dash
  \melodyb r2.
  R1.*4
  \melodya-dash
  \melodyb
  \melodyc
  \key des \major
  \transpose c des { \melodyb r2. }
  \transpose c des { \melodyb }
  \transpose c des { \melody-last }
  r2.
  R1.
}

melody-transposed = \transpose c f, { \melody }
upper-midi-transposed = \transpose c f, { \upper-midi }
lower-midi-transposed = \transpose c f, { \lower-midi }
upper-print-transposed = \transpose c f, { \upper-print }
lower-print-transposed = \transpose c f, { \lower-print }

\book {
\score {
  <<
    % \new ChordNames {
      % \guitarchords
    % }
    \new Staff = "melodystaff" <<
      \set Staff.midiInstrument = #"electric guitar (clean)"
      \set Staff.instrumentName = #"Voice"
      \set Staff.midiMinimumVolume = #0.9
      \set Staff.midiMaximumVolume = #1
      \new Voice = "melody" {
        \melody-transposed
      }
      \context Lyrics = "lyrics" { \lyricsto "melody" { \lyricsmain } }
    >>
    \new PianoStaff <<
      \set Staff.midiInstrument = #"acoustic grand"
      \set Staff.instrumentName = #"Piano"
      \new Staff = "right" {
        \set Staff.midiMinimumVolume = #0.5
        \set Staff.midiMaximumVolume = #0.6
        \upper-midi-transposed
      }
      \new Staff = "left" {
        \set Staff.midiMinimumVolume = #0.5
        \set Staff.midiMaximumVolume = #0.6
        \lower-midi-transposed
      }
    >>
  >>
  \midi {
    \context {
      \ChordNameVoice \remove Note_performer
    }
  }
}
}
\book {
\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t
      % \guitarchords
    }
    \new Staff = "melodystaff" \with {
      fontSize = #-3
      \override StaffSymbol.staff-space = #(magstep -3)
      \override StaffSymbol.thickness = #(magstep -3)
    }
    <<
      \set Staff.midiInstrument = #"choir aahs"
      \set Staff.instrumentName = #"Voice"
      \new Voice = "melody" {
        \melody-transposed
      }
      \context Lyrics = "lyrics" { \lyricsto "melody" { \lyricsmain } }
    >>
    \new PianoStaff <<
      \set PianoStaff.connectArpeggios = ##t
      \set Staff.midiInstrument = #"acoustic grand"
      \set Staff.instrumentName = #"Piano"
      \new Staff = "right" { \upper-print-transposed }
      \new Dynamics = "Dynamics_pf" \dynamics
      \new Staff = "left" { \lower-print-transposed }
    >>
  >>
  \layout {
    \context {
      % add the RemoveEmptyStaffContext that erases rest-only staves
      \Staff \RemoveEmptyStaves
    }
    \context {
      % add the RemoveEmptyStaffContext that erases rest-only staves
      \Dynamics \RemoveEmptyStaves
    }
    \context {
      \Score
      % Remove all-rest staves also in the first system
      \override VerticalAxisGroup.remove-first = ##t
      % If only one non-empty staff in a system exists, still print the starting bar
      \override SystemStartBar.collapse-height = #1
    }
    \context {
      \ChordNames
      \override ChordName #'font-size = #-3
    }
  }
}
}
