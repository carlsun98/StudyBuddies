/* First page of app for logging in and creating StudyBuddy account.
 * TODO: -styling
 *       -link it to Server
 *       -make buttons redirect properly
 *******************************************************************/

'use strict';

import React, { Component } from 'react';

import {
    StackNavigator, 
} from 'react-navigation';

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
import CreateUser from './CreateUser';
import Settings from './Settings';
import GroupPage from './GroupPage';

export default class ClassPage extends Component<{}> {
    constructor(){
	super()
	this.state = {
            username: '',
            password: '',
	}
    }
    _handleActiveGroupPress() {
	console.log(this.state.username);
	console.log(this.state.password);
    }

    render() {
	return (

		<View style={styles.container}>
		<View style={styles.buttons}>
		<Button
            onPress={() => this._handleActiveGroupPress()} 
            title = "Active Groups">
		</Button>
		</View>
		
		<View style={styles.buttons}>
		<Button 
            onPress={() => this.props.navigation.navigate('CreateUser')}
            title = "See Group Locations">
		</Button>
		</View>

		<View style={styles.buttons}>   
		<Button 
            onPress={() => this.props.navigation.navigate('Settings')}
            title = "Create Group">
		</Button>
		</View>
	</View>
	);
    }
}

