package com.cuvenx.androiddropdownmenu

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.*
import androidx.compose.material.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.MoreVert
import androidx.compose.runtime.Composable
import androidx.compose.runtime.MutableState
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.cuvenx.androiddropdownmenu.ui.theme.AndroidDropdownMenuTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            AndroidDropdownMenuTheme {
                MainContent()
            }
        }
    }
}

@Composable
fun MainContent() {
    val bodyContent = remember { mutableStateOf("Select menu to change content") }

    Scaffold(
        topBar = {
            TopAppBar(
                title = {
                    Text(text = "App Title")
                },
                actions = {
                    TopAppBarDropdownMenu(bodyContent)
                })
        }) {
        Column(
            horizontalAlignment = Alignment.CenterHorizontally,
            modifier = Modifier
                .fillMaxWidth()
                .padding(20.dp)) {
            Text(bodyContent.value)
        }
    }
}

@Composable
fun TopAppBarDropdownMenu(bodyContent: MutableState<String>) {
    val expanded = remember { mutableStateOf(false) }

    Box(
        Modifier
            .wrapContentSize(Alignment.TopEnd)
    ) {
        IconButton(onClick = {
            expanded.value = true
            bodyContent.value =  "Menu Opening"
        }) {
            Icon(
                Icons.Filled.MoreVert,
                contentDescription = "More Menu"
            )
        }
    }

    DropdownMenu(
        expanded = expanded.value,
        onDismissRequest = { expanded.value = false },
    ) {
        DropdownMenuItem(onClick = {
            expanded.value = false
            bodyContent.value = "First Item Selected"
        }) {
            Text("First item")
        }

        Divider()

        DropdownMenuItem(onClick = {
            expanded.value = false
            bodyContent.value = "Second Item Selected"
        }) {
            Text("Second item")
        }

        Divider()

        DropdownMenuItem(onClick = {
            expanded.value = false
            bodyContent.value = "Third Item Selected"
        }) {
            Text("Third item")
        }

        Divider()

        DropdownMenuItem(onClick = {
            expanded.value = false
            bodyContent.value = "Fourth Item Selected"
        }) {
            Text("Fourth item")
        }
    }
}

@Preview(showBackground = true)
@Composable
fun DefaultPreview() {
    AndroidDropdownMenuTheme {
        MainContent()
    }
}