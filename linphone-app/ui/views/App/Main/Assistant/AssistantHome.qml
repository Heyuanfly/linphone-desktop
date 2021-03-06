import QtQuick 2.7
import QtQuick.Layouts 1.3

import Common 1.0
import Linphone 1.0

import App.Styles 1.0

// =============================================================================

ColumnLayout {
  spacing: 0
  
  // ---------------------------------------------------------------------------
  // Info.
  // ---------------------------------------------------------------------------

  Item {
    Layout.fillHeight: true
    Layout.fillWidth: true

    Column {
      anchors.verticalCenter: parent.verticalCenter
      spacing: 0

      height: AssistantHomeStyle.info.height
      width: parent.width

      Icon {
        anchors.horizontalCenter: parent.horizontalCenter

        icon: 'home_account_assistant'
        iconSize: AssistantHomeStyle.info.iconSize
      }

      Text {
        height: AssistantHomeStyle.info.title.height
        width: parent.width

        color: AssistantHomeStyle.info.title.color
        elide: Text.ElideRight
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        font {
          bold: true
          pointSize: AssistantHomeStyle.info.title.pointSize
        }

        text: qsTr('homeTitle')
      }

      Text {
        height: AssistantHomeStyle.info.description.height
        width: parent.width

        color: AssistantHomeStyle.info.description.color
        elide: Text.ElideRight
        font.pointSize: AssistantHomeStyle.info.description.pointSize
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        text: qsTr('homeDescription')
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Buttons.
  // ---------------------------------------------------------------------------

  GridView {
    id: buttons

    Layout.alignment: Qt.AlignHCenter
    Layout.fillWidth: true
    Layout.maximumWidth: AssistantHomeStyle.buttons.maxWidth
    Layout.preferredHeight: AssistantHomeStyle.buttons.height
    Layout.leftMargin: AssistantStyle.leftMargin
    Layout.rightMargin: AssistantStyle.rightMargin
    Layout.bottomMargin: AssistantStyle.bottomMargin

    cellHeight: height / 2
    cellWidth: width / 2

    delegate: Item {
      height: buttons.cellHeight
      width: buttons.cellWidth

      TextButtonA {
        anchors {
          fill: parent
          margins: AssistantHomeStyle.buttons.spacing
        }

        enabled: SettingsModel[$viewType.charAt(0).toLowerCase() + $viewType.slice(1) + "Enabled"]
        text: $text.replace('%1', Qt.application.name.toUpperCase())

		onClicked:{ assistant.pushView($view, $props) }
      }
    }

    model: ListModel {
      Component.onCompleted: {
        insert(0, {
          $text: qsTr('createAppSipAccount'),
          $view: 'CreateAppSipAccount',
          $viewType: 'CreateAppSipAccount',
		  $props:{defaultUrl: SettingsModel.assistantRegistrationUrl, defaultLogoutUrl:SettingsModel.assistantLogoutUrl, configFilename: 'create-app-sip-account.rc'}
        })
        append({
                $text: qsTr('useAppSipAccount'),
                $view: 'CreateAppSipAccount',
                $viewType: 'UseAppSipAccount',
                $props:{defaultUrl: SettingsModel.assistantLoginUrl, defaultLogoutUrl:SettingsModel.assistantLogoutUrl, configFilename: 'use-app-sip-account.rc'}
        })
        append({
                $text: qsTr('useOtherSipAccount'),
                $view: 'UseOtherSipAccount',
                $viewType: 'UseOtherSipAccount'
        })
        append( {
                $text: qsTr('fetchRemoteConfiguration'),
                $view: 'FetchRemoteConfiguration',
                $viewType: 'FetchRemoteConfiguration'
        })
      }
    }

    interactive: false
  }
}
