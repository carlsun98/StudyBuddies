/* Page to display when user has asked for email to be sent with
 *  with registration link inside. Should allow user to go back to 
 * previous submission page, but otherwise does nothing.
 * TODO: -styling
 *       -make sure email sends and redirects properly
 *****************************************************************/

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

export default class AwaitingConfirmation extends Component<{}> {

    render() {
	return (
		<View style={styles.container}>

		<Text style={styles.description}>
		Your confirmation email was sent to {this.props.navigation.state.params.email}! 
            </Text>
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
    }
});
