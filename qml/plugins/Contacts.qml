import QtQuick 2.0
import Sailfish.Silica 1.0
import QtContacts 5.0

Item {
    id: contactsPlugin
    property variant webview
    property string callbackID
    property string errCallbackID

    ContactModel {
        id: contactsModel
        //manager: "memory"
        Component.onCompleted: {
            //contactsModel.importContacts(Qt.resolvedUrl("example.vcf"))
            /*page.insertContact("Mary", "Curie", "+41791234545")
                            page.insertContact("Empress", "of Blandings", "+41791234546")
                            page.insertContact("Big", "Lebowski", "+41791234546")
                            page.insertContact("Clive", "Sinclair", "+41791234546")
                            page.insertContact("Winston", "Churchill", "+41791234547")*/
        }
        sortOrders: [
            SortOrder {
                detail: ContactDetail.Name
                field: Name.FirstName
                direction: Qt.AscendingOrder
            }
        ]
        /*filter: DetailFilter {
                            detail: ContactDetail.Name
                            field: Name.FirstName
                            value: "Mum"
                            matchFlags: Filter.MatchStartsWith
                        }*/
    }

    Dialog {
        id: dialogContacts

        Column {
            spacing: 10
            anchors.fill: parent

            ListView {
                id: list
                width: parent.width
                height:parent.height
                model: contactsModel
                delegate: Component {
                    id: contactListDelegate
                    ListItem {
                        id: listItem

                        /*Image {
                            id: avatar
                            source: contact.thumbnail
                            sourceSize.width: 60
                            sourceSize.height: 60
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                        }*/

                        Text {
                            id: nameText
                            text: ""
                            color: "white"
                            anchors.leftMargin: 10
                            font.family: "Helvetica"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
        }
    }

    function search(options) {
        contactsPlugin.webview = options.webview
        contactsPlugin.callbackID = options.params.shift()
        contactsPlugin.errCallbackID = options.params.shift()
        var result = [];
       // contactsModel.contacts.organization
        for(var p in contactsModel.contacts) {
            console.log(p, contactsModel.contacts[p].name.firstName)
            var c = {
                id: p,
                displayName: contactsModel.contacts[p].name.firstName,
                name: contactsModel.contacts[p].name.lastName,
                nickname: contactsModel.contacts[p].name.nickName,
                phoneNumbers: [contactsModel.contacts[p].phoneNumber.number],
                emails: [contactsModel.contacts[p].email.emailAddress],
                birthday: contactsModel.contacts[p].birthday,
                note: contactsModel.contacts[p].note,
                urls: [contactsModel.contacts[p].url],
                adresses:[
                    {
                        streetAddress: contactsModel.contacts[p].address.street,
                        country: contactsModel.contacts[p].address.country,
                        postalCode: contactsModel.contacts[p].address.postcode,
                        region: contactsModel.contacts[p].address.region,
                        locality: contactsModel.contacts[p].address.locality
                    }
                ],
                organizations:[
                    {
                        name: contactsModel.contacts[p].organization.name,
                        department: contactsModel.contacts[p].organization.department,
                        title: contactsModel.contacts[p].organization.title
                    }
                ]
            }
            result.push(c)
        }
        //dialogContacts.open()
        contactsPlugin.webview.experimental.evaluateJavaScript("cordova.callback(%1,%2)".arg(contactsPlugin.callbackID).arg(JSON.stringify(result)));
    }
}
