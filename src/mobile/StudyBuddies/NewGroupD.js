/* Last page of create group flow. Allows user to choose group purpose
 * (General Review, Exam Cramming, or Homework) as well as write a
 * description with any other details they want other users to see
 * when thinking about joining.
 * TODO: -styling
 *       -add purpose options
 *       -link it to store descriptions
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
import GroupPage from './GroupPage'
import styles from './stylings';

export default class NewGroupD extends Component<{}> {
    constructor(){
	super()
	this.state = {
            groupCategory: '',
            groupDesc: '',
	}
    }
    _handlePress() {
	console.log(this.state.groupCategory);
    console.log(this.state.groupDesc);
	this.props.navigation.navigate('GroupPage')
    }

render() {
    return (

        <View style={styles.container}>

        <Text style={styles.description}>
        You Are Making a New Group!
            </Text>

        <View style={styles.inputBoxes}>
        <View style={{flexDirection: 'row'}}>
        <Text>
        Purpose of Group:
            </Text>

        <TextInput 
            style={styles.searchInput}
            placeholder='     '
            returnKeyType = {"next"}
        onChangeText={(text) => this.setState({groupCategory:text})}
            />
            </View>
            </View>

        <View style={styles.inputBoxes}>
        <View style={{flexDirection: 'row'}}>
        <Text>
        Description:
            </Text>

        <TextInput 
            style={styles.searchInput}
            placeholder='     '
            returnKeyType = {"next"}
        onChangeText={(text) => this.setState({groupDesc:text})}
            />
            </View>
            </View>


        <View style={styles.buttons}>
        <Button
            onPress={() => this._handlePress()} 
            title = "Done">
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
