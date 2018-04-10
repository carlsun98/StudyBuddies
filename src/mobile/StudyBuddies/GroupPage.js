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
import styles from './stylings';
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

