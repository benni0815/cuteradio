/*
 * Copyright (C) 2014 Stuart Howarth <showarth@marxoft.co.uk>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms and conditions of the GNU Lesser General Public License,
 * version 3, as published by the Free Software Foundation.
 *
 * This program is distributed in the hope it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
 * more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software Foundation,
 * Inc., 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1

MyQueryDialog {
    id: root

    height: contentItem.height
    titleText: "cuteRadio " + VERSION_NUMBER
    icon: "images/cuteradio.png"
    content: Item {
        id: contentItem

        height: column.height + 90
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            margins: platformStyle.paddingLarge
        }

        Column {
            id: column

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
            spacing: platformStyle.paddingLarge

            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: qsTr("A user-friendly internet radio player and client for the cuteRadio internet radio service.<br><br>&copy; Stuart Howarth 2014")
            }

            LinkLabel {
                width: parent.width
                wrapMode: Text.Wrap
                text: qsTr("View changelog")
                onClicked: {
                    appWindow.pageStack.push(Qt.resolvedUrl("ChangelogPage.qml"));
                    root.accept();
                }
            }

            LinkLabel {
                width: parent.width
                text: "<font color ='" + platformStyle.colorNormalLight + "'>" + qsTr("Contact") + ": </font><u>showarth@marxoft.co.uk</u>"
                link: "mailto:showarth@marxoft.co.uk?subject=cuteRadio " + VERSION_NUMBER + " for Symbian"
                onClicked: root.accept()
            }
        }
    }
}
