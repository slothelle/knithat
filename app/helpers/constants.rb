module SizeAbbrevsConstants
  ABBREVIATIONS = { k: 'knit', p: 'purl', sl: 'slip', pm: 'place marker',
                    slm: 'slip marker', k2tog: 'knit 2 together', co: 'cast on',
                    bo: 'bind off', st: 'stitch', sts: 'stitches', rpt: 'repeat',
                    rpts: 'repeats' }

  HAT_SIZES = { infant: [13, 15],
                  child: [17, 20, 21],
                  adult: [22, 23, 25] }

  def print_abbreviations
    legend = ABBREVIATIONS.map do |abbrev, definition|
      "<li class='abbreviations'>#{abbrev}: #{definition}</li>"
    end
    legend.join
  end
end