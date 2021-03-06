import QtQuick 2.7
import QtQuick.Controls 2.7
import QtQuick.Layouts 1.3

import Common 1.0
import Common.Styles 1.0
import Linphone 1.0
import Utils 1.0

import App.Styles 1.0

// =============================================================================

DialogPlus {
  property var call

  // ---------------------------------------------------------------------------

  buttons: [
    TextButtonB {
      text: qsTr('ok')

      onClicked: {
        call.updateStreams()
        exit(0)
      }
    }
  ]

  buttonsAlignment: Qt.AlignCenter

  height: MultimediaParametersStyle.height+30
  width: MultimediaParametersStyle.width

  onCallChanged: !call && exit(0)

  // ---------------------------------------------------------------------------

  Column {
    anchors.fill: parent
    spacing: MultimediaParametersStyle.column.spacing

    RowLayout {
      spacing: MultimediaParametersStyle.column.entry.spacing
      width: parent.width

      Icon {
        Layout.alignment: Qt.AlignTop
        Layout.preferredHeight: ComboBoxStyle.background.height

        icon: MultimediaParametersStyle.column.entry.speaker.icon
        overwriteColor: MultimediaParametersStyle.column.entry.speaker.color
        iconSize: MultimediaParametersStyle.column.entry.speaker.iconSize
      }

      Column {
        Layout.fillWidth: true

        spacing: MultimediaParametersStyle.column.entry.spacing2

        ComboBox {
          currentIndex: Utils.findIndex(model, function (device) {
            return device === SettingsModel.playbackDevice
          })
          model: SettingsModel.playbackDevices
          width: parent.width

          onActivated: SettingsModel.playbackDevice = model[index]
        }

        Slider {
	  id: playbackSlider
          width: parent.width

          Component.onCompleted: value = call.speakerVolumeGain
          onPositionChanged: call.speakerVolumeGain = position

	  ToolTip {
	    parent: playbackSlider.handle
	    visible: playbackSlider.pressed
	    text: (playbackSlider.value * 100).toFixed(0) + " %"
	  }
        }
      }
    }

    RowLayout {
      spacing: MultimediaParametersStyle.column.entry.spacing
      width: parent.width

      Icon {
        Layout.alignment: Qt.AlignTop
        Layout.preferredHeight: ComboBoxStyle.background.height

        icon: MultimediaParametersStyle.column.entry.micro.icon
        overwriteColor: MultimediaParametersStyle.column.entry.micro.color
        iconSize: MultimediaParametersStyle.column.entry.micro.iconSize
      }

      Column {
        Layout.fillWidth: true

        spacing: MultimediaParametersStyle.column.entry.spacing2

        ComboBox {
          currentIndex: Utils.findIndex(model, function (device) {
            return device === SettingsModel.captureDevice
          })
          model: SettingsModel.captureDevices
          width: parent.width

          onActivated: SettingsModel.captureDevice = model[index]
        }

        Slider {
	  id: captureSlider
          width: parent.width

          Component.onCompleted: value = call.microVolumeGain
          onPositionChanged: call.microVolumeGain = position

	  ToolTip {
	    parent: captureSlider.handle
	    visible: captureSlider.pressed
	    text: "+ " + (captureSlider.value * 100).toFixed(0) + " %"
	  }
        }
      }
    }

    RowLayout {
      spacing: MultimediaParametersStyle.column.entry.spacing
      width: parent.width

      Icon {
        icon: MultimediaParametersStyle.column.entry.camera.icon
        overwriteColor: MultimediaParametersStyle.column.entry.camera.color
        iconSize: MultimediaParametersStyle.column.entry.speaker.iconSize
      }

      ComboBox {
        Layout.fillWidth: true

        currentIndex: Number(Utils.findIndex(model, function (device) {
          return device === SettingsModel.videoDevice
        }))
        model: SettingsModel.videoDevices

        onActivated: SettingsModel.videoDevice = model[index]
      }
    }
  }
}
