/* Page user sees after tapping on a class they are currently following.
 * Allows user to redirect to map to see where current groups are, as
 * well as create a group.
 * TODO: -styling
 *       -Link to server so email sends and redirects
 *********************************************************************/

'use strict';

import React, { Component } from 'react';
import {

    StyleSheet,
    Text,
    TextInput,
    View,
    Button,
    ActivityIndicator,
    Image,
} from 'react-native';

export default class GroupPage extends Component<{}> {
    constructor(){
	super()

	this.state = {
	    username: '',
	    password: '',
	}
    }
    render() {
	return (
		<View style={styles.container}>

		<View style={styles.buttons}>
		<Text>
		  Class Abbrv and # Go Here
		</Text>
	        </View>

	        <View style={styles.buttons}>
		<Text>
		  Location Goes Here
		</Text>
	        </View>

	        <View style={styles.buttons}>
		<Text>
		  Members List/Button to see it goes here
		</Text>
	        </View>
	    </View>
	);
    }
}

const styles = StyleSheet.create({
    description: {
	marginBottom: 20,
	fontSize: 18,
	textAlign: 'center',
	color: '#656565'
    },

    descriptionAsk: {
	marginBottom: 20,
	fontSize: 18,
	textAlign: 'left',
	color: '#656565'
    },

    container: {
	padding: 30,
	marginTop: 65,
	flex: 1
    },
    buttons: {
	alignItems: 'center',
	paddingVertical: 15
    },
    inputBoxes: {
	alignItems: 'center',
	padding: 10
    },
    searchInput: {
	height: 36,
	padding: 4,
	marginRight: 5,
	marginLeft: 5,
	fontSize: 18,
	borderWidth: 1,
	borderColor: '#48BBEC',
	borderRadius: 8,
	color: '#48BBEC',
    },
});
