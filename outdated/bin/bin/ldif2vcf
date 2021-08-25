#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Auteur: manuel BERROCAL
# <manu.berrocal@absolacom.com>
# Date: 17-10-2010

"""
Convertisseur de fichier ldif -> vcf
Lit un fichier ldif et le convertit au format vcf (pour roundcube)
Roundcube ne lit que les fichiers vcf pour importer des contacts
Thunderbird n'exporte qu'en ldif ou cvs
Ce programme permet dimporter dans roundcube les contacts de thunderbird.
ATTENTION: il n'y a pas de synchronisation entre les deux!!!
"""

#       ldif2vcf.py
#
#       Copyright 2010 manuel BERROCAL <manu.berrocal@absolacom.com>
#
#       This program is free software; you can redistribute it and/or modify
#       it under the terms of the GNU General Public License as published by
#       the Free Software Foundation; either version 2 of the License, or
#       (at your option) any later version.
#
#       This program is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#       GNU General Public License for more details.
#
#       You should have received a copy of the GNU General Public License
#       along with this program; if not, write to the Free Software
#       Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#       MA 02110-1301, USA.


import os, os.path, sys

# Permet d'être certain que les  fichier situés dans le même répertoire
# seront trouvés en toute circonstance
HERE = os.path.dirname(sys.argv[0])
APPDIR = os.path.abspath(HERE)
sys.path.insert(0, APPDIR)
os.chdir(APPDIR)

def create_vcard(nom, prenom, nomaffiche, mail, telephoneNumber, fileout):
    """
    Crée le format vcard avec les éléments transmis et l'enregistre dans le
    fichier si le fichier de sortie a été renseigné
    """
    if fileout == None:
        print "BEGIN:VCARD"
        print "VERSION:3.0"
        print "FN:%s" % nomaffiche
        print "N:%s;%s;;;" % (nom, prenom)
        print "EMAIL;type=INTERNET;type=HOME;type=pref:%s" % mail
        print "TEL;TYPE=HOME,VOICE:%s" % telephoneNumber
        print "END:VCARD\n"
    else:
        sortie = open(fileout, 'a')
        sortie.write("BEGIN:VCARD\n")
        sortie.write("VERSION:3.0\n")
        sortie.write("FN:%s\n" % nomaffiche)
        sortie.write("N:%s;%s;;;\n" % (nom, prenom))
        sortie.write("EMAIL;type=INTERNET;type=HOME;type=pref:%s\n" % mail)
        sortie.write("TEL;TYPE=HOME,VOICE:%s" % telephoneNumber)
        sortie.write("END:VCARD\n")
        sortie.close()

def main(fichdif, fichout):
    """
    Lancement du programme principal
    """
    if not os.path.isfile(fichdif):
        print "File %s not found. Exiting." % fichdif
        sys.exit(1)

    if not fichout == None:
        sortie = open(fichout, 'w')
        sortie.close()


    # c'est ici que sont définis les champs recherchés. Ils sont stockés
    # dans des variables qui seront transmises à la fonction qui crée le
    # fichier vcard
    for elem in open(fichdif).readlines():
        if not "objectclass:" in elem and not "telephoneNumber:" in elem \
                and not "mobile:" in elem:
            if "dn: " in elem:
                nom = ""
                prenom = ""
                mail = ""
                nomaffiche = ""
                telephoneNumber = ""
            elif "mail: " in elem:
                mail = elem.split(":")[1].strip()
            elif "givenName:" in elem:
                prenom = elem.split(":")[1].strip()
            elif "sn:" in elem:
                nom = elem.split(":")[1].strip()
            elif "cn:" in elem:
                nomaffiche = elem.split(":")[1].strip()
            elif "telephoneNumber:" in elem:
                telephoneNumber = elem.split(":")[1].strip()
            elif "modifytimestamp:" in elem:
                # le "modifytimestamp" est la dernière information de la fiche
                # de chaque contact. Une fois sur ce champ, on crée la fiche
                # vcard avec les variables contenant les infos relevées
                create_vcard(nom, prenom, nomaffiche, mail, telephoneNumber, fichout)


if __name__ == '__main__':
    from optparse import OptionParser
    USAGE_ = "see %prog --help for help \nCe programme permet de convertir un \
fichier au format ldif vers le format vcf pour roundcube"
    PARSER = OptionParser(usage = USAGE_ , version = "0.101017-0")

    PARSER.add_option("-f", "--file", dest = "file", default = None,
                      help = "Fichier ldif à traiter",
                       metavar = "FILE")
    PARSER.add_option("-o", "--output", dest = "output", default = None,
                      help = "Indique la sortie du logiciel. Par défaut \
la sortie standard.")
    (OPTIONS, ARGS) = PARSER.parse_args()

    if OPTIONS.file == None or OPTIONS.file == "":
        print "You MUST specify a ldif file to convert. Exiting."
        print "See help for more information."
        sys.exit(1)

    else:
        main(OPTIONS.file, OPTIONS.output)



















