/* Third page of create group flow. Needs to allow user to choose
 * how long the group will (initially) exist for before being
 * automatically disbanded. 
 * TODO: -styling
 *       -proper setup of time choosing
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
import NewGroupD from './NewGroupD'
import styles from './stylings';

export default class NewGroupC extends Component<{}> {
    constructor(){
	super()
	this.state = {
            groupHours: '',
            groupMinutes: '',
	}
    }
    _handlePress() {
	console.log(this.state.groupHours);
    console.log(this.state.groupMinutes);
	this.props.navigation.navigate('NewGroupD')
    }

    render() {
	return (

		<View style={styles.container}>

		<Text style={styles.description}>
		You Are Making a New Group!
            </Text>

		<Text style={styles.description}>
		About how long will you study for?
            </Text>

        <View style={styles.inputBoxes}>
        <View style={{flexDirection: 'row'}}>
        <Text>
        Hours:
            </Text>

        <TextInput 
            style={styles.searchInput}
            placeholder='     '
            returnKeyType = {"next"}
        onChangeText={(text) => this.setState({groupHours:text})}
            />
            </View>
            </View>

        <View style={styles.inputBoxes}>
        <View style={{flexDirection: 'row'}}>
        <Text>
        Minutes:
            </Text>

        <TextInput 
            style={styles.searchInput}
            placeholder='     '
            returnKeyType = {"next"}
        onChangeText={(text) => this.setState({groupMinutes:text})}
            />
            </View>
            </View>


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
