/* Second page of create group flow. Lets user choose location (using
 * Google Maps).
 * TODO: -styling
 *       -include Google Maps
 *       -link Map to stoing locations in DB
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
import NewGroupC from './NewGroupC'
import styles from './stylings';

export default class NewGroupB extends Component<{}> {
    constructor(){
	super()
	this.state = {
            groupLocation: '',
	}
    }
    _handlePress() {
	console.log(this.state.groupClass);
	this.props.navigation.navigate('NewGroupC')
    }

    render() {
	return (

		<View style={styles.container}>

		<Text style={styles.description}>
		You Are Making a New Group!
            </Text>

		<Text style={styles.description}>
		Where do you want the class to be?
            </Text>

  		<TextInput 
    	    style={styles.searchInput}
    	    placeholder='     '
    	    returnKeyType = {"next"}
 	    onChangeText={(text) => this.setState({groupLocation:text})}
    		/>

		<View style={styles.buttons}>
		<Button
            onPress={() => this._handlePress()} 
            title = "Next Step">
		</Button>
		</View>

	    </View>
	);
    }
}

/*const styles = StyleSheet.create({
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
}); */