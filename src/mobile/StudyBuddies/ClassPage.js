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
    inputBoxes: {
	alignItems: 'center',
	padding: 10
    },
    buttons: {
	alignItems: 'center',
	paddingVertical: 15
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
