def see_alsos(alsos):
    ''' Expects a list of terms to create <glossseealso/> elements for '''
    result = '\n'
    for term in alsos:
        if len(term) > 0:
            xml_id = "gloss-" + term.replace(' ', '-')
            result += """    <glossseealso otherterm="%s" />\n""" % xml_id
    return result


f = open('./glossary.txt', 'r')
glossary = [ l.strip().split('|') for l in f.readlines() ]
f.close()

o = open('glosxml', 'w')
for l in glossary:
    alsos = see_alsos(l[2].split(','))
    xml_id = "gloss-" + l[0].replace(' ', '-')

    o.write("""<glossentry xml:id="%s">
  <glossterm>%s</glossterm>
  <glossdef>
    <para>%s</para>%s  </glossdef>
</glossentry>

""" % (xml_id, l[0], l[1], alsos))


o.flush()
o.close()
