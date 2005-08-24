#!/bin/sh

function substitute
{
   OLD=${1}
   NEW=${2}
   for name in *.xml; do
      echo -n "Doing ${name}..."
      sed -e "s/${OLD}/${NEW}/" < ${name} > ${name}.new
      mv ${name}.new ${name}
      echo " done."
   done
}

substitute '=\"poss-' '=\"'
