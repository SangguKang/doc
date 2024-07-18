#!/bin/bash

language="Korean"

function learn() {
    learn_language="English"
    echo "I am learning $learn_language"
}

function print() {
    echo "I cna speak $1"
}

learn
print $language
print $learn_language
