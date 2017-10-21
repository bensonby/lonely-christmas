\version "2.18.2"

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
  title = "陳奕迅 - Lonely Christmas"
  subtitle = "For female voice and piano accompaniment"
  arranger = "Arranged by Benson"
}

lower-melodya = \relative c {
  e2. d c bes4. aes
  ees'2. d des c4. bes
  g'2. ges f4. e dis2.
  d2. d,4 e8~ e fis4 g2.~ g2.
}

upper-melodya = \relative c' {
  \clef treble
  <g' a c>2. <f a c> <e g b> <c f a>4 a'8 <c, ees g c>8 bes' aes
  <c, d g>2. <e fis cis'> <e gis b>4. gis8 a b <f g c>8 bes aes g4.
  <f bes d>2. <a cis e>4. f'8 e d <d, g a c>4. <d g b> <cis fis a>2.
  <f a c>2. <f aes c>4 <f d'>8~ q <c' e>4 <f, aes d>4.
}

upper-midi = \relative c' {
  \set Staff.pedalSustainStyle = #'bracket
  \key c \major
  \clef treble
  \tempo 4. = 78
  \time 12/8
  \upper-melodya
  \bar "|."
}

lower-midi = \relative c {
  \set Staff.pedalSustainStyle = #'bracket
  \key c \major
  \clef bass
  \time 12/8
  \lower-melodya
  \bar "|."
}

upper-print = \relative c' {
  \set Staff.pedalSustainStyle = #'bracket
  \key c \major
  \clef treble
  \tempo 4. = 78
  \time 12/8
  \upper-melodya
  \bar "|."
}

lower-print = \relative c {
  \set Staff.pedalSustainStyle = #'bracket
  \key c \major
  \clef bass
  \time 12/8
  \lower-melodya
  \bar "|."
}

dynamics = {
  s1
}

guitarchords = \chordmode {
  a2.:m7/e d:m7 c:maj7 bes,4.:maj9 aes,:maj7
  ees2.:maj13 d:maj9 des:m7 f4.:m9/c bes,:m13
  g2.:m7 fis:m9 d4.:m11/f e:m7 b2.:maj9/dis
  d2.:m7 d4:m7.5- c:11/e fis:m7.5- b2.:dim7/g
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
}

melodyb = \relative c' {
}

melody = \relative c' {
  \key c \major
  \clef treble
  \time 12/8
  \melodya
  \melodya-dash
  \melodyb
}


\book {
\score {
  <<
    \new ChordNames {
      \guitarchords
    }
    \new Staff = "melodystaff" <<
      \set Staff.midiInstrument = #"choir aahs"
      \set Staff.instrumentName = #"Voice"
      \new Voice = "melody" {
        \melody
      }
      \context Lyrics = "lyrics" { \lyricsto "melody" { \lyricsmain } }
    >>
    \new PianoStaff <<
      \set Staff.midiInstrument = #"acoustic grand"
      \set Staff.instrumentName = #"Piano"
      \new Staff = "right" { \upper-midi }
      \new Staff = "left" { \lower-midi }
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
      \guitarchords
    }
    \new Staff = "melodystaff" \with {
      fontSize = #-3
      \override StaffSymbol.staff-space = #(magstep -3)
    }
    <<
      \set Staff.midiInstrument = #"choir aahs"
      \set Staff.instrumentName = #"Voice"
      \new Voice = "melody" {
        \melody
      }
      \context Lyrics = "lyrics" { \lyricsto "melody" { \lyricsmain } }
    >>
    \new PianoStaff <<
      \set Staff.midiInstrument = #"acoustic grand"
      \set Staff.instrumentName = #"Piano"
      \new Staff = "right" { \upper-print }
      \new Dynamics = "Dynamics_pf" \dynamics
      \new Staff = "left" { \lower-print }
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
