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
import com.nokia.meego 1.0
import org.marxoft.cuteradio 1.0
import "file:///usr/lib/qt4/imports/com/nokia/meego/UIConstants.js" as UI

MyPage {
    id: root

    property variant station: {
        "id": "",
        "title": qsTr("Unknown"),
        "description": qsTr("Unknown"),
        "genre": qsTr("Unknown"),
        "country": qsTr("Unknown"),
        "language": qsTr("Unknown"),
        "logo": "",
        "source": "",
        "is_favourite": false,
        "favourite_id": "",
        "last_played": ""
    }

    title: station.title
    tools: ToolBarLayout {

        BackToolIcon {}

        NowPlayingButton {}

        ToolIcon {
            anchors.right: parent.right
            platformIconId: "toolbar-edit"
            visible: stationModel.source == "mystations"
            onClicked: {
                loader.sourceComponent = addStationDialog;
                loader.item.open();
                loader.item.stationId = station.id;
                loader.item.title = station.title;
                loader.item.description = station.description;
                loader.item.genre = station.genre;
                loader.item.country = station.country;
                loader.item.language = station.language;
                loader.item.logo = station.logo;
                loader.item.source = station.source;
            }
        }
    }

    Flickable {
        id: flicker

        anchors {
            fill: parent
            margins: UI.PADDING_DOUBLE
        }
        contentHeight: column.height + UI.PADDING_DOUBLE

        Column {
            id: column

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
            spacing: UI.PADDING_DOUBLE

            Logo {
                width: 120
                height: 120
                source: station.logo
                text: station.title
                enabled: player.currentStation.id != station.id
                onClicked: player.playStation(station)
            }

            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: station.description
            }

            SeparatorLabel {
                width: parent.width
                text: qsTr("Properties")
            }

            Label {
                width: parent.width
                elide: Text.ElideRight
                font.pixelSize: UI.FONT_SMALL
                text: qsTr("Genre") + ": " + station.genre
            }

            Label {
                width: parent.width
                elide: Text.ElideRight
                font.pixelSize: UI.FONT_SMALL
                text: qsTr("Country") + ": " + station.country
            }

            Label {
                width: parent.width
                elide: Text.ElideRight
                font.pixelSize: UI.FONT_SMALL
                text: qsTr("Language") + ": " + station.language
            }

            Label {
                width: parent.width
                elide: Text.ElideRight
                font.pixelSize: UI.FONT_SMALL
                text: qsTr("Source") + ": " + station.source
            }

            Label {
                width: parent.width
                elide: Text.ElideRight
                font.pixelSize: UI.FONT_SMALL
                text: qsTr("Last played") + ": " + (station.last_played ? station.last_played : qsTr("Never"))
            }
        }
    }

    ScrollDecorator {
        flickableItem: flicker
    }

    Loader {
        id: loader
    }

    Component {
        id: addStationDialog

        AddStationDialog {
            onAccepted: {
                root.station = result;
                stationModel.setItemData(stationModel.match("id", stationId), result);
                infoBanner.showMessage(qsTr("Station updated"));
            }
        }
    }
}
