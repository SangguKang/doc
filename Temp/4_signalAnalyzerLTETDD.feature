Feature: test for LTE TDD Signal Analyzer

  Background:
    Given I have connected device by ssh to DEV_IP
    And  I registry "signalAnalyzerLTETDDBuildIn_app" and "signalAnalyzerLTETDDBuildIn_reg_module" to "spectrum_module".
    
#######################################################################################################################
  Scenario: Test changing tech mode
    When I change mode "signalAnalyzerLTETDDBuildIn_app" mode.
    Then I make sure "signalAnalyzerLTETDDBuildIn_app" mode has changed.

########################################################################################################################
  Scenario Outline: presetActn Test
    When I call Action <act>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                    |expectValue  |act         |
      |measurementModeCnfg                   |spectrum           |presetActn |

#######################################################################################################################
  Scenario Outline: bandwidth Test
    When I change <id> value to <inputValue>.
    Then I make sure that <targetid> value is equal to <expectValue>.

    Examples:
      |id               | targetid    |inputValue   |   expectValue |
      |bandwidthCnfg   |  bandwidthCnfg | Bandwidth14       |  Bandwidth14 |
      |bandwidthCnfg   |  bandwidthCnfg | Bandwidth3       |Bandwidth3       |
      |bandwidthCnfg   |  bandwidthCnfg | Bandwidth5       |Bandwidth5       |
      |bandwidthCnfg   |  bandwidthCnfg | Bandwidth10       |Bandwidth10       |
      |bandwidthCnfg   |  bandwidthCnfg | Bandwidth15       |Bandwidth15       |
      |bandwidthCnfg   |  bandwidthCnfg | Bandwidth20       |Bandwidth20       |
      |bandwidthCnfg   |  spanFrequencyCnfg | Bandwidth14       |  10 |
      |bandwidthCnfg   |  spanFrequencyCnfg | Bandwidth3       |20       |
      |bandwidthCnfg   |  spanFrequencyCnfg | Bandwidth5       |30       |
      |bandwidthCnfg   |  spanFrequencyCnfg | Bandwidth10       |50       |
      |bandwidthCnfg   |  spanFrequencyCnfg | Bandwidth15       |75       |
      |bandwidthCnfg   |  spanFrequencyCnfg | Bandwidth20       |100       |

#######################################################################################################################
  Scenario: 10 MHz Bandwidth test
    When I set item flow table.
      |id                       |setValue   |
      |centerFrequencyCnfg  |1000       |
      |bandwidthCnfg          |Bandwidth14 |
      |bandwidthCnfg          |Bandwidth10 |

    Then I verify items flow table by floating.
      |id                       |expectValue|
      |spanFrequencyCnfg      |50     |
      |centerFrequencyCnfg    |1000      |
      |startFrequencyCnfg     |975    |
      |stopFrequencyCnfg      |1025   |

#######################################################################################################################
  Scenario: 1.4 MHz Bandwidth test
    When I set item flow table.
      |id                       |setValue   |
      |centerFrequencyCnfg  |1000       |
      |bandwidthCnfg          |Bandwidth14 |

    Then I verify items flow table by floating.
      |id                       |expectValue|
      |spanFrequencyCnfg      |10     |
      |centerFrequencyCnfg    |1000      |
      |startFrequencyCnfg     |995    |
      |stopFrequencyCnfg      |1005   |

#######################################################################################################################
  Scenario: center frequency move to low limit with 10 MHz Bandwidth
    When I set item flow table.
      |id                       |setValue   |
      |bandwidthCnfg          |Bandwidth10 |
      |centerFrequencyCnfg  |1        |

    Then I verify items flow table by floating.
      |id                       |expectValue|
      |spanFrequencyCnfg      |50     |
      |centerFrequencyCnfg    |125    |
      |startFrequencyCnfg     |100    |
      |stopFrequencyCnfg      |150    |

#######################################################################################################################
  Scenario: center frequency move to High limit with 10 MHz Bandwidth
    When I set item flow table.
      |id                       |setValue   |
      |bandwidthCnfg          |Bandwidth10 |
      |centerFrequencyCnfg  |6000       |

    Then I verify items flow table by floating.
      |id                       |expectValue|
      |spanFrequencyCnfg      |50     |
      |centerFrequencyCnfg    |5975   |
      |startFrequencyCnfg     |5950   |
      |stopFrequencyCnfg      |6000   |

#######################################################################################################################
  Scenario: start frequency move to Low limit with 10 MHz Bandwidth
    When I set item flow table.
      |id                       |setValue   |
      |bandwidthCnfg          |Bandwidth10 |
      |startFrequencyCnfg |0        |

    Then I verify items flow table by floating.
      |id                       |expectValue|
      |spanFrequencyCnfg      |50     |
      |centerFrequencyCnfg    |125    |
      |startFrequencyCnfg     |100    |
      |stopFrequencyCnfg      |150    |

#######################################################################################################################
  Scenario: start frequency move to High limit with 10 MHz Bandwidth
    When I set item flow table.
      |id                       |setValue   |
      |bandwidthCnfg          |Bandwidth10 |
      |startFrequencyCnfg     |8000       |

    Then I verify items flow table by floating.
      |id                       |expectValue|
      |spanFrequencyCnfg      |50     |
      |centerFrequencyCnfg    |5975   |
      |startFrequencyCnfg     |5950   |
      |stopFrequencyCnfg      |6000   |

#######################################################################################################################
  Scenario: stop frequency move to Low limit with 10 MHz Bandwidth
    When I set item flow table.
      |id                       |setValue   |
      |bandwidthCnfg          |Bandwidth10 |
      |stopFrequencyCnfg      |0        |

    Then I verify items flow table by floating.
      |id                       |expectValue|
      |spanFrequencyCnfg      |50     |
      |centerFrequencyCnfg    |125    |
      |startFrequencyCnfg     |100    |
      |stopFrequencyCnfg      |150    |

#######################################################################################################################
  Scenario: stop frequency move to High limit with 10 MHz Bandwidth
    When I set item flow table.
      |id                       |setValue   |
      |bandwidthCnfg          |Bandwidth10 |
      |stopFrequencyCnfg      |8000       |

    Then I verify items flow table by floating.
      |id                       |expectValue|
      |spanFrequencyCnfg      |50     |
      |centerFrequencyCnfg    |5975   |
      |startFrequencyCnfg     |5950   |
      |stopFrequencyCnfg      |6000   |

#######################################################################################################################
  Scenario Outline: step frequency test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <id> value is equal to <expectValue>.

    Examples:
      |id                   |inputValue   |   expectValue |
      |stepFrequencyCnfg  | -1       |  0.000001 |
      |stepFrequencyCnfg  | 0.009       |  0.009 |
      |stepFrequencyCnfg  | 100       |  100 |
      |stepFrequencyCnfg  | 6000       |  1000 |
      |stepFrequencyCnfg  | 100000       |  1000 |

#######################################################################################################################
  Scenario Outline: step Channel Number test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                   |inputValue   |   expectValue |
      |channelStepCnfg  | -1       |  1 |
      |channelStepCnfg  | 50       |  50 |
      |channelStepCnfg  | 100       |  100 |
      |channelStepCnfg  | 101       |  101 |
      |channelStepCnfg  | 10000       |  10000 |
      |channelStepCnfg  | 10001       |  10000 |
      |channelStepCnfg  | 100000       |  10000 |

#######################################################################################################################
  Scenario Outline: reference Level test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <id> value is equal to <expectValue>.

    Examples:
      |id                   |inputValue   |   expectValue |
      |referenceLevelCnfg  | 101       |  100 |
      |referenceLevelCnfg  | 100       |  100 |
      |referenceLevelCnfg  | 99.99       |  99.99 |
      |referenceLevelCnfg  | -119.99       | -119.99  |
      |referenceLevelCnfg  | -120       |  -120 |
      |referenceLevelCnfg  | -121       |  -120 |

#######################################################################################################################
  Scenario Outline: referenceModeCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                   |inputValue   |   expectValue |
      |referenceModeCnfg  | Absolute       |  Absolute |
      |referenceModeCnfg  | Relative       |  Relative |
      |referenceModeCnfg  | Absolute       |  Absolute |
      |referenceModeCnfg  | asd       |  Absolute |

#######################################################################################################################
  Scenario Outline: referenceTimeCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                   |inputValue   |   expectValue |
      |referenceTimeCnfg  | 9       |  10 |
      |referenceTimeCnfg  | 10       |  10 |
      |referenceTimeCnfg  | 11       |  11 |
      |referenceTimeCnfg  | 199       |  199 |
      |referenceTimeCnfg  | 200       |  200 |
      |referenceTimeCnfg  | 201       |  200 |

#######################################################################################################################
  Scenario Outline: Attenuation Test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <id> value is equal to <expectValue>.

    Examples:
      |id                   |inputValue   |   expectValue |
      |attenuationValueCnfg  | -1       |  0 |
      |attenuationValueCnfg  | 0       |  0 |
      |attenuationValueCnfg  | 1       |  0 |
      |attenuationValueCnfg  | 2       | 0  |
      |attenuationValueCnfg  | 3       |  0 |
      |attenuationValueCnfg  | 4       |  0 |
      |attenuationValueCnfg  | 5       |  5 |
      |attenuationValueCnfg  | 10       |  10 |
      |attenuationValueCnfg  | 15       |  15 |
      |attenuationValueCnfg  | 20       |  20 |
      |attenuationValueCnfg  | 25       |  25 |
      |attenuationValueCnfg  | 30       |  30 |
      |attenuationValueCnfg  | 35       |  35 |
      |attenuationValueCnfg  | 40       |  40 |
      |attenuationValueCnfg  | 45       |  45 |
      |attenuationValueCnfg  | 50       |  50 |
      |attenuationValueCnfg  | 54       |  50 |
      |attenuationValueCnfg  | 55       |  55 |
      |attenuationValueCnfg  | 56       |  55 |

#######################################################################################################################
  Scenario Outline: preamp mode test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue  |
      |attenuationValueCnfg               |10           |10           |
      |preampCnfg                         |On           |On           |
      |preampCnfg                         |Off          |Off          |

#######################################################################################################################
  Scenario: Preamp and attenuation relation test if preamp off,  when atten set 15 dB
    When I set item flow table.
      |id                       |setValue   |
      |preampCnfg               |On |
      |attenuationValueCnfg   |15       |

    Then I verify items flow table.
      |id                       |expectValue|
      |preampCnfg             |Off    |

#######################################################################################################################
  Scenario: Preamp and attenuation relation test if atten set 10 dB,  when preamp on
    When I set item flow table.
      |id                       |setValue   |
      |attenuationValueCnfg   |15       |
      |preampCnfg               |On |

    Then I verify items flow table.
      |id                       |expectValue|
      |attenuationValueCnfg  |10    |

#######################################################################################################################
  Scenario Outline: Attenuation Mode test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue  |
      |attenuationModeCnfg              |Auto         |Auto           |
      |attenuationModeCnfg              |Manual       |Manual           |
      |attenuationModeCnfg              |Couple       |Couple          |
      |attenuationModeCnfg              |Auto         |Auto           |
      |attenuationModeCnfg              |asd          |Auto          |

#######################################################################################################################
  Scenario: reference level and attenuation relation test if reference level is ,  when atten mode couple and reference level set 0
    When I set item flow table.
      |id                       |setValue   |
      |preampCnfg               |On         |
      |attenuationModeCnfg    |Couple   |
      |referenceLevelCnfg       |20         |
      |referenceLevelCnfg       |0         |

    Then I verify items flow table.
      |id                       |expectValue|
      |attenuationValueCnfg  |20    |
      |preampCnfg               |Off      |

#######################################################################################################################
  Scenario Outline: External offset test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <id> value is equal to <expectValue>.

    Examples:
      |id                   |inputValue   |   expectValue |
      |externalOffsetCnfg  | 101       |  100 |
      |externalOffsetCnfg  | 100       |  100 |
      |externalOffsetCnfg  | 99.99       |  99.99 |
      |externalOffsetCnfg  | -119.99       | -119.99  |
      |externalOffsetCnfg  | -120       |  -120 |
      |externalOffsetCnfg  | -121       |  -120 |

#######################################################################################################################
  Scenario Outline: external offset Mode test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue  |
      |externalOffsetModeCnfg              |Off       |Off           |
      |externalOffsetModeCnfg              |On         |On           |
      |externalOffsetModeCnfg              |asd          |On          |
      |externalOffsetModeCnfg              |Off       |Off           |
      |externalOffsetModeCnfg              |asd          |Off          |

#######################################################################################################################
  Scenario: external offset mode test when external offset set
    When I set item flow table.
      |id                       |setValue   |
      |externalOffsetModeCnfg      |Off         |
      |externalOffsetCnfg       |20         |
      |externalOffsetCnfg       |0         |

    Then I verify items flow table.
      |id                       |expectValue|
      |externalOffsetModeCnfg  |On    |

#######################################################################################################################
  Scenario Outline: scale division test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <id> value is equal to <expectValue>.

    Examples:
      |id                   |inputValue   |   expectValue |
      |scaleDivisionCnfg  | 0       |  1 |
      |scaleDivisionCnfg  | 1       |  1 |
      |scaleDivisionCnfg  | 1.1       |  1.1 |
      |scaleDivisionCnfg  | 19.9       |  19.9 |
      |scaleDivisionCnfg  | 20       |  20 |
      |scaleDivisionCnfg  | 20.1       |  20 |

#######################################################################################################################
  Scenario Outline: scale unit test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue  |
      |scaleUnitCnfg              |dBm       |dBm           |
      |scaleUnitCnfg              |dBV         |dBV           |
      |scaleUnitCnfg              |dBmV          |dBmV          |
      |scaleUnitCnfg              |dBuV       |dBuV           |
      |scaleUnitCnfg              |V          |V          |
      |scaleUnitCnfg              |W          |W          |

#######################################################################################################################
  Scenario Outline: average test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue  |
      |averageCnfg              |0       |1           |
      |averageCnfg              |1       |1           |
      |averageCnfg              |10      |10          |
      |averageCnfg              |99      |99           |
      |averageCnfg              |100     |100          |
      |averageCnfg              |101     |100          |

#######################################################################################################################
  Scenario Outline: select trace test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue  |
      |selectTraceCnfg              |Trace06       |Trace06           |
      |selectTraceCnfg              |Trace05       |Trace05           |
      |selectTraceCnfg              |Trace04       |Trace04          |
      |selectTraceCnfg              |Trace03       |Trace03          |
      |selectTraceCnfg              |Trace02       |Trace02          |
      |selectTraceCnfg              |Trace01       |Trace01          |

#######################################################################################################################
  Scenario Outline: select trace info test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue  |
      |selectTraceInfoCnfg              |Trace06       |Trace06           |
      |selectTraceInfoCnfg              |Trace05       |Trace05           |
      |selectTraceInfoCnfg              |Trace04       |Trace04          |
      |selectTraceInfoCnfg              |Trace03       |Trace03          |
      |selectTraceInfoCnfg              |Trace02       |Trace02          |
      |selectTraceInfoCnfg              |Trace01       |Trace01          |
      |selectTraceInfoCnfg              |asd           |Trace01          |

#######################################################################################################################
  Scenario Outline: hold time trace test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue  |
      |holdTimeTraceCnfg              |-1       |0           |
      |holdTimeTraceCnfg              |0       |0           |
      |holdTimeTraceCnfg              |1       |1          |
      |holdTimeTraceCnfg              |10       |10          |
      |holdTimeTraceCnfg              |99       |99          |
      |holdTimeTraceCnfg              |100       |100          |
      |holdTimeTraceCnfg              |101           |100          |

#######################################################################################################################
  Scenario Outline: type trace test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue  |
      |typeTraceCnfg01              |Off            |Off           |
      |typeTraceCnfg01              |ClearWrite     |ClearWrite    |
      |typeTraceCnfg01              |Capture       |Capture           |
      |typeTraceCnfg01              |Max       |Max           |
      |typeTraceCnfg01              |Min       |Min          |
      |typeTraceCnfg01              |Load       |Load          |
      |typeTraceCnfg01              |ClearWrite     |ClearWrite    |
      |typeTraceCnfg01              |Calculate       |ClearWrite          |
      |typeTraceCnfg06              |Off            |Off           |
      |typeTraceCnfg06              |ClearWrite     |ClearWrite    |
      |typeTraceCnfg06              |Capture       |Capture           |
      |typeTraceCnfg06              |Max       |Max           |
      |typeTraceCnfg06              |Min       |Min          |
      |typeTraceCnfg06              |Load       |Load          |
      |typeTraceCnfg06              |ClearWrite     |ClearWrite    |
      |typeTraceCnfg06              |Calculate       |Calculate          |

#######################################################################################################################
  Scenario Outline: view trace test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue  |
      |viewTraceCnfg06              |On            |On           |
      |viewTraceCnfg06              |Off            |Off           |
      |viewTraceCnfg01              |Off            |Off           |
      |viewTraceCnfg01              |On            |On           |

#######################################################################################################################
  Scenario: Trace Clear all action Test
    When I act item flow table.
      |id                       |
      | traceClearAllActn     |
      Then I verify items flow table.
      |id                       |expectValue|
      |viewTraceCnfg01        |On     |
      |typeTraceCnfg01        |ClearWrite     |
      |viewTraceCnfg02        |Off    |
      |typeTraceCnfg02        |Off    |
      |viewTraceCnfg03        |Off    |
      |typeTraceCnfg03        |Off    |
      |viewTraceCnfg04        |Off    |
      |typeTraceCnfg04        |Off    |
      |viewTraceCnfg05        |Off    |
      |typeTraceCnfg05        |Off    |
      |viewTraceCnfg06        |Off    |
      |typeTraceCnfg06        |Off    |

#######################################################################################################################
  Scenario: when view trace on  Test
    When I set item flow table.
      |id                       | setValue    |
      | viewTraceCnfg01     | On              |
      | typeTraceCnfg01     | ClearWrite      |
      | viewTraceCnfg02     | On              |
      | typeTraceCnfg02     | ClearWrite      |
      | viewTraceCnfg03     | On              |
      | typeTraceCnfg03     | ClearWrite      |
      | viewTraceCnfg04     | On              |
      | typeTraceCnfg04     | ClearWrite      |
      | viewTraceCnfg05     | On              |
      | typeTraceCnfg05     | ClearWrite      |
      | viewTraceCnfg06     | On              |
      | typeTraceCnfg06     | ClearWrite      |
      | viewTraceCnfg01     | On              |
      | typeTraceCnfg01     | ClearWrite      |

    Then I verify items flow table.
      |id                       |expectValue|
      |typeTraceCnfg06       |Capture     |
      |typeTraceCnfg05       |Capture     |
      |typeTraceCnfg04       |Capture     |
      |typeTraceCnfg03       |Capture     |
      |typeTraceCnfg02       |Capture     |
      |typeTraceCnfg01       |ClearWrite    |

#######################################################################################################################
  Scenario: type trace was set Calculate   Test
    When I set item flow table.
      |id                       | setValue    |
      | viewTraceCnfg01     | On              |
      | typeTraceCnfg01     | ClearWrite      |
      | viewTraceCnfg02     | On              |
      | typeTraceCnfg02     | ClearWrite      |
      | viewTraceCnfg03     | On              |
      | typeTraceCnfg03     | ClearWrite      |
      | viewTraceCnfg04     | On              |
      | typeTraceCnfg04     | ClearWrite      |
      | viewTraceCnfg05     | On              |
      | typeTraceCnfg05     | Calculate      |
      | viewTraceCnfg06     | On              |
      | typeTraceCnfg06     | Calculate      |
      | viewTraceCnfg01     | On              |
      | typeTraceCnfg01     | ClearWrite      |

    Then I verify items flow table.
      |id                       |expectValue|
      |typeTraceCnfg06       |Calculate     |
      |typeTraceCnfg05       |Calculate     |
      |typeTraceCnfg04       |Capture     |
      |typeTraceCnfg03       |Capture     |
      |typeTraceCnfg02       |Capture     |
      |typeTraceCnfg01       |ClearWrite    |

#######################################################################################################################
  Scenario: type trace was not set Calculate   Test
    When I set item flow table.
      |id                       | setValue    |
      | viewTraceCnfg01     | On              |
      | typeTraceCnfg01     | ClearWrite      |
      | viewTraceCnfg02     | On              |
      | typeTraceCnfg02     | ClearWrite      |
      | viewTraceCnfg03     | On              |
      | typeTraceCnfg03     | ClearWrite      |
      | viewTraceCnfg04     | On              |
      | typeTraceCnfg04     | ClearWrite      |
      | viewTraceCnfg02     | Off              |
      | viewTraceCnfg03     | Off              |
      | viewTraceCnfg05     | On              |
      | typeTraceCnfg05     | Calculate      |
      | viewTraceCnfg06     | On              |
      | typeTraceCnfg06     | Calculate      |
      | viewTraceCnfg01     | On              |
      | typeTraceCnfg01     | ClearWrite      |

    Then I verify items flow table.
      |id                       |expectValue|
      |typeTraceCnfg06       |Capture     |
      |typeTraceCnfg05       |Capture     |
      |typeTraceCnfg04       |Capture     |
      |typeTraceCnfg03       |Capture     |
      |typeTraceCnfg02       |Capture     |
      |typeTraceCnfg01       |ClearWrite    |
      |viewTraceCnfg06         |On           |
      |viewTraceCnfg05         |On           |
      |viewTraceCnfg04         |On           |
      |viewTraceCnfg03         |Off           |
      |viewTraceCnfg02         |Off           |
      |viewTraceCnfg01         |On           |

#######################################################################################################################
  Scenario Outline: mode Chart test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue  |
      |modeChartCnfg              |Off            |Off           |
      |modeChartCnfg              |On     |On    |
      |modeChartCnfg              |Off       |Off           |
      |modeChartCnfg              |asd       |Off           |

#######################################################################################################################
  Scenario Outline: displayDataAllocCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue  |
      |displayDataAllocCnfg              |PDSCH            |PDSCH           |
      |displayDataAllocCnfg              |Both       |Both           |
      |displayDataAllocCnfg              |PMCH     |PMCH    |
      |displayDataAllocCnfg              |PDSCH            |PDSCH           |
      |displayDataAllocCnfg              |asd       |PDSCH           |

  Scenario Outline: typeChartCACnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue  |
      |typeChartCACnfg              |Modulation            |Modulation           |
      |typeChartCACnfg              |Spectrum       |Spectrum           |
      |typeChartCACnfg              |Modulation     |Modulation    |
      |typeChartCACnfg              |asd       |Modulation           |

#######################################################################################################################
  Scenario Outline: displayItemCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue  |
      |displayItemCnfg              |Power            |Power           |
      |displayItemCnfg              |EVM       |EVM           |
      |displayItemCnfg              |Power     |Power    |
      |displayItemCnfg              |asd       |Power           |

#######################################################################################################################
  Scenario Outline: transparencyCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                   |inputValue   |   expectValue |
      |transparencyCnfg  | -1       |  0 |
      |transparencyCnfg  | 0       |  0 |
      |transparencyCnfg  | 1       |  1 |
      |transparencyCnfg  | 50       |  50 |
      |transparencyCnfg  | 99       |  99 |
      |transparencyCnfg  | 100       |  100 |
      |transparencyCnfg  | 101       |  100 |

#######################################################################################################################
  Scenario Outline: displayOptionsCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |displayOptionsCnfg              |Off           |Off           |
      |displayOptionsCnfg              |On            |On             |
      |displayOptionsCnfg              |Off           |Off           |
      |displayOptionsCnfg              |asd           |Off           |

#######################################################################################################################
  Scenario Outline: selectMarkerCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |selectMarkerCnfg              |Marker06           |Marker06           |
      |selectMarkerCnfg              |Marker01           |Marker01             |
      |selectMarkerCnfg              |Marker02           |Marker02           |
      |selectMarkerCnfg              |Marker03           |Marker03           |
      |selectMarkerCnfg              |Marker04           |Marker04           |
      |selectMarkerCnfg              |Marker05           |Marker05             |
      |selectMarkerCnfg              |Marker06           |Marker06           |
      |selectMarkerCnfg              |Marker01           |Marker01             |
      |selectMarkerCnfg              |asd                 |Marker01           |

#######################################################################################################################
  Scenario Outline: viewMarkerCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |viewMarkerCnfg01              |Off           |Off           |
      |viewMarkerCnfg01              |On           |On           |
      |viewMarkerCnfg01              |Off           |Off           |
      |viewMarkerCnfg02              |Off           |Off           |
      |viewMarkerCnfg02              |On           |On           |
      |viewMarkerCnfg02              |Off           |Off           |
      |viewMarkerCnfg03              |Off           |Off           |
      |viewMarkerCnfg03              |On           |On           |
      |viewMarkerCnfg03              |Off           |Off           |
      |viewMarkerCnfg04              |Off           |Off           |
      |viewMarkerCnfg04              |On           |On           |
      |viewMarkerCnfg04              |Off           |Off           |
      |viewMarkerCnfg05              |Off           |Off           |
      |viewMarkerCnfg05              |On           |On           |
      |viewMarkerCnfg05              |Off           |Off           |
      |viewMarkerCnfg06              |Off           |Off           |
      |viewMarkerCnfg06              |On           |On           |
      |viewMarkerCnfg06              |Off           |Off           |

#######################################################################################################################
  Scenario Outline: typeMarkerCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |typeMarkerCnfg01              |Delta           |Delta           |
      |typeMarkerCnfg01              |DeltaPair           |DeltaPair           |
      |typeMarkerCnfg01              |Normal           |Normal           |
      |typeMarkerCnfg02              |Delta           |Delta           |
      |typeMarkerCnfg02              |DeltaPair           |DeltaPair           |
      |typeMarkerCnfg02              |Normal           |Normal           |
      |typeMarkerCnfg03              |Delta           |Delta           |
      |typeMarkerCnfg03              |DeltaPair           |DeltaPair           |
      |typeMarkerCnfg03              |Normal           |Normal           |
      |typeMarkerCnfg04              |Delta           |Delta           |
      |typeMarkerCnfg04              |DeltaPair           |DeltaPair           |
      |typeMarkerCnfg04              |Normal           |Normal           |
      |typeMarkerCnfg05              |Delta           |Delta           |
      |typeMarkerCnfg05              |DeltaPair           |DeltaPair           |
      |typeMarkerCnfg05              |Normal           |Normal           |
      |typeMarkerCnfg06              |Delta           |Delta           |
      |typeMarkerCnfg06              |DeltaPair           |DeltaPair           |
      |typeMarkerCnfg06              |Normal           |Normal           |

#######################################################################################################################
  Scenario Outline: frequencyMarkerCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |bandwidthCnfg                  |Bandwidth14           |Bandwidth14           |
      |bandwidthCnfg                  |Bandwidth10           |Bandwidth10           |
      |centerFrequencyCnfg              |1000           |1000           |
      |frequencyMarkerCnfg01              |974.9           |975           |
      |frequencyMarkerCnfg01              |975           |975           |
      |frequencyMarkerCnfg01              |975.1           |975.1           |
      |frequencyMarkerCnfg01              |1024.9           |1024.9           |
      |frequencyMarkerCnfg01              |1025           |1025           |
      |frequencyMarkerCnfg01              |1025.1           |1025           |
      |frequencyMarkerCnfg02              |974.9           |975           |
      |frequencyMarkerCnfg02              |975           |975           |
      |frequencyMarkerCnfg02              |975.1           |975.1           |
      |frequencyMarkerCnfg02              |1024.9           |1024.9           |
      |frequencyMarkerCnfg02              |1025           |1025           |
      |frequencyMarkerCnfg02              |1025.1           |1025           |
      |frequencyMarkerCnfg03              |974.9           |975           |
      |frequencyMarkerCnfg03              |975           |975           |
      |frequencyMarkerCnfg03              |975.1           |975.1           |
      |frequencyMarkerCnfg03              |1024.9           |1024.9           |
      |frequencyMarkerCnfg03              |1025           |1025           |
      |frequencyMarkerCnfg03              |1025.1           |1025           |
      |frequencyMarkerCnfg04              |974.9           |975           |
      |frequencyMarkerCnfg04              |975           |975           |
      |frequencyMarkerCnfg04              |975.1           |975.1           |
      |frequencyMarkerCnfg04              |1024.9           |1024.9           |
      |frequencyMarkerCnfg04              |1025           |1025           |
      |frequencyMarkerCnfg04              |1025.1           |1025           |
      |frequencyMarkerCnfg05              |974.9           |975           |
      |frequencyMarkerCnfg05              |975           |975           |
      |frequencyMarkerCnfg05              |975.1           |975.1           |
      |frequencyMarkerCnfg05              |1024.9           |1024.9           |
      |frequencyMarkerCnfg05              |1025           |1025           |
      |frequencyMarkerCnfg05              |1025.1           |1025           |
      |frequencyMarkerCnfg06              |974.9           |975           |
      |frequencyMarkerCnfg06              |975           |975           |
      |frequencyMarkerCnfg06              |975.1           |975.1           |
      |frequencyMarkerCnfg06              |1024.9           |1024.9           |
      |frequencyMarkerCnfg06              |1025           |1025           |
      |frequencyMarkerCnfg06              |1025.1           |1025           |

#######################################################################################################################
  Scenario Outline: alwaysPeakCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |alwaysPeakCnfg01              |Off           |Off           |
      |alwaysPeakCnfg01              |On           |On           |
      |alwaysPeakCnfg01              |Off           |Off           |
      |alwaysPeakCnfg02              |Off           |Off           |
      |alwaysPeakCnfg02              |On           |On           |
      |alwaysPeakCnfg02              |Off           |Off           |
      |alwaysPeakCnfg03              |Off           |Off           |
      |alwaysPeakCnfg03              |On           |On           |
      |alwaysPeakCnfg03              |Off           |Off           |
      |alwaysPeakCnfg04              |Off           |Off           |
      |alwaysPeakCnfg04              |On           |On           |
      |alwaysPeakCnfg04              |Off           |Off           |
      |alwaysPeakCnfg05              |Off           |Off           |
      |alwaysPeakCnfg05              |On           |On           |
      |alwaysPeakCnfg05              |Off           |Off           |
      |alwaysPeakCnfg06              |Off           |Off           |
      |alwaysPeakCnfg06              |On           |On           |
      |alwaysPeakCnfg06              |Off           |Off           |

#######################################################################################################################
  Scenario Outline: frequencyDeltaMarkerCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                              |targetid   |inputValue   |expectValue    |
      |centerFrequencyCnfg           |centerFrequencyCnfg             |1000           |1000           |
      |viewMarkerCnfg01              |viewMarkerCnfg01                |On           |On           |
      |frequencyMarkerCnfg01         |frequencyMarkerCnfg01           |1001           |1001           |
      |typeMarkerCnfg01              |frequencyDeltaMarkerCnfg01    |Delta           |1001           |
      |viewMarkerCnfg01              |viewMarkerCnfg01                |Off           |Off           |
      |viewMarkerCnfg02              |viewMarkerCnfg02                |On           |On           |
      |frequencyMarkerCnfg02         |frequencyMarkerCnfg02           |1001           |1001           |
      |typeMarkerCnfg02              |frequencyDeltaMarkerCnfg02    |Delta           |1001           |
      |viewMarkerCnfg02              |viewMarkerCnfg02                |Off           |Off           |
      |viewMarkerCnfg03              |viewMarkerCnfg03                |On           |On           |
      |frequencyMarkerCnfg03         |frequencyMarkerCnfg03           |1001           |1001           |
      |typeMarkerCnfg03              |frequencyDeltaMarkerCnfg03    |Delta           |1001           |
      |viewMarkerCnfg03              |viewMarkerCnfg03                |Off           |Off           |
      |viewMarkerCnfg04              |viewMarkerCnfg04                |On           |On           |
      |frequencyMarkerCnfg04         |frequencyMarkerCnfg04           |1001           |1001           |
      |typeMarkerCnfg04              |frequencyDeltaMarkerCnfg04    |Delta           |1001           |
      |viewMarkerCnfg04              |viewMarkerCnfg04                |Off           |Off           |
      |viewMarkerCnfg05              |viewMarkerCnfg05                |On           |On           |
      |frequencyMarkerCnfg05         |frequencyMarkerCnfg05           |1001           |1001           |
      |typeMarkerCnfg05              |frequencyDeltaMarkerCnfg05    |Delta           |1001           |
      |viewMarkerCnfg05              |viewMarkerCnfg05                |Off           |Off           |
      |viewMarkerCnfg06              |viewMarkerCnfg06                |On           |On           |
      |frequencyMarkerCnfg06         |frequencyMarkerCnfg06           |1001           |1001           |
      |typeMarkerCnfg06              |frequencyDeltaMarkerCnfg06    |Delta           |1001           |
      |viewMarkerCnfg06              |viewMarkerCnfg06                |Off           |Off           |

#######################################################################################################################
  Scenario Outline: onTraceMarkerCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <targetid> value is equal to <expectValue>.

    Examples:
      |id                            |targetid     |inputValue   |expectValue    |
      |typeTraceCnfg01              |typeTraceCnfg01   |ClearWrite           |ClearWrite           |
      |viewMarkerCnfg01              |viewMarkerCnfg01                |On           |On           |
      |selectTraceCnfg              |selectTraceCnfg                  |Trace01      |Trace01      |
      |selectMarkerCnfg              |onTraceMarkerCnfg01  |Marker01           |Trace01           |
      |typeTraceCnfg02              |typeTraceCnfg02   |ClearWrite           |ClearWrite           |
      |viewMarkerCnfg02              |viewMarkerCnfg02                |On           |On           |
      |selectTraceCnfg              |selectTraceCnfg                  |Trace02      |Trace02      |
      |selectMarkerCnfg              |onTraceMarkerCnfg02  |Marker02           |Trace02           |
      |typeTraceCnfg03              |typeTraceCnfg03   |ClearWrite           |ClearWrite           |
      |viewMarkerCnfg03              |viewMarkerCnfg03                |On           |On           |
      |selectTraceCnfg              |selectTraceCnfg                  |Trace03      |Trace03      |
      |selectMarkerCnfg              |onTraceMarkerCnfg03  |Marker03           |Trace03           |
      |typeTraceCnfg04              |typeTraceCnfg04   |ClearWrite           |ClearWrite           |
      |viewMarkerCnfg04              |viewMarkerCnfg04                |On           |On           |
      |selectTraceCnfg              |selectTraceCnfg                  |Trace04      |Trace04      |
      |selectMarkerCnfg              |onTraceMarkerCnfg04  |Marker04           |Trace04           |
      |typeTraceCnfg05              |typeTraceCnfg05   |ClearWrite           |ClearWrite           |
      |viewMarkerCnfg05              |viewMarkerCnfg05                |On           |On           |
      |selectTraceCnfg              |selectTraceCnfg                  |Trace05      |Trace05      |
      |selectMarkerCnfg              |onTraceMarkerCnfg05  |Marker05           |Trace05           |
      |typeTraceCnfg06              |typeTraceCnfg06   |ClearWrite           |ClearWrite           |
      |viewMarkerCnfg06              |viewMarkerCnfg06                |On           |On           |
      |selectTraceCnfg              |selectTraceCnfg                  |Trace06      |Trace06      |
      |selectMarkerCnfg              |onTraceMarkerCnfg06  |Marker06           |Trace06           |
      |selectTraceCnfg              |selectTraceCnfg  |Trace01           |Trace01           |
      |selectMarkerCnfg             |selectMarkerCnfg   |Marker01         |Marker01           |
      |viewMarkerCnfg01              |viewMarkerCnfg01                |Off           |Off           |
      |viewMarkerCnfg02              |viewMarkerCnfg02                |Off           |Off           |
      |viewMarkerCnfg03              |viewMarkerCnfg03                |Off           |Off           |
      |viewMarkerCnfg04              |viewMarkerCnfg04                |Off           |Off           |
      |viewMarkerCnfg05              |viewMarkerCnfg05                |Off           |Off           |
      |viewMarkerCnfg06              |viewMarkerCnfg06                |Off           |Off           |
      |viewTraceCnfg01              |viewTraceCnfg01   |Off           |Off           |
      |viewTraceCnfg02              |viewTraceCnfg02   |Off           |Off           |
      |viewTraceCnfg03              |viewTraceCnfg03   |Off           |Off           |
      |viewTraceCnfg04              |viewTraceCnfg04   |Off           |Off           |
      |viewTraceCnfg05              |viewTraceCnfg05   |Off           |Off           |
      |viewTraceCnfg06              |viewTraceCnfg06   |Off           |Off           |

#######################################################################################################################
  Scenario Outline: onTraceDeltaMarkerCnfg01 test when select trace set
    When I change <id> value to <inputValue>.
    Then I make sure that <targetid> value is equal to <expectValue>.

    Examples:
      |id                            |targetid     |inputValue   |expectValue    |
      |typeTraceCnfg01              |typeTraceCnfg01   |ClearWrite           |ClearWrite           |
      |viewMarkerCnfg01              |viewMarkerCnfg01                |On           |On           |
      |typeMarkerCnfg01              |typeMarkerCnfg01                |Delta        |Delta        |
      |selectTraceCnfg              |selectTraceCnfg                  |Trace01      |Trace01      |
      |selectMarkerCnfg              |onTraceDeltaMarkerCnfg01  |Marker01           |Trace01           |
      |typeTraceCnfg02              |typeTraceCnfg02   |ClearWrite           |ClearWrite           |
      |viewMarkerCnfg02              |viewMarkerCnfg02                |On           |On           |
      |typeMarkerCnfg02              |typeMarkerCnfg02                |Delta        |Delta        |
      |selectTraceCnfg              |selectTraceCnfg                  |Trace02      |Trace02      |
      |selectMarkerCnfg              |onTraceDeltaMarkerCnfg02  |Marker02           |Trace02           |
      |typeTraceCnfg03              |typeTraceCnfg03   |ClearWrite           |ClearWrite           |
      |viewMarkerCnfg03              |viewMarkerCnfg03                |On           |On           |
      |typeMarkerCnfg03              |typeMarkerCnfg03                |Delta        |Delta        |
      |selectTraceCnfg              |selectTraceCnfg                  |Trace03      |Trace03      |
      |selectMarkerCnfg              |onTraceDeltaMarkerCnfg03  |Marker03           |Trace03           |
      |typeTraceCnfg04              |typeTraceCnfg04   |ClearWrite           |ClearWrite           |
      |viewMarkerCnfg04              |viewMarkerCnfg04                |On           |On           |
      |typeMarkerCnfg04              |typeMarkerCnfg04                |Delta        |Delta        |
      |selectTraceCnfg              |selectTraceCnfg                  |Trace04      |Trace04      |
      |selectMarkerCnfg              |onTraceDeltaMarkerCnfg04  |Marker04           |Trace04           |
      |typeTraceCnfg05              |typeTraceCnfg05   |ClearWrite           |ClearWrite           |
      |viewMarkerCnfg05              |viewMarkerCnfg05                |On           |On           |
      |typeMarkerCnfg05              |typeMarkerCnfg05                |Delta        |Delta        |
      |selectTraceCnfg              |selectTraceCnfg                  |Trace05      |Trace05      |
      |selectMarkerCnfg              |onTraceDeltaMarkerCnfg05  |Marker05           |Trace05           |
      |typeTraceCnfg06              |typeTraceCnfg06   |ClearWrite           |ClearWrite           |
      |viewMarkerCnfg06              |viewMarkerCnfg06                |On           |On           |
      |typeMarkerCnfg06              |typeMarkerCnfg06                |Delta        |Delta        |
      |selectTraceCnfg              |selectTraceCnfg                  |Trace06      |Trace06      |
      |selectMarkerCnfg              |onTraceDeltaMarkerCnfg06  |Marker06           |Trace06           |
      |selectTraceCnfg              |selectTraceCnfg  |Trace01           |Trace01           |
      |selectMarkerCnfg             |selectMarkerCnfg   |Marker01         |Marker01           |
      |viewMarkerCnfg01              |viewMarkerCnfg01                |Off           |Off           |
      |viewMarkerCnfg02              |viewMarkerCnfg02                |Off           |Off           |
      |viewMarkerCnfg03              |viewMarkerCnfg03                |Off           |Off           |
      |viewMarkerCnfg04              |viewMarkerCnfg04                |Off           |Off           |
      |viewMarkerCnfg05              |viewMarkerCnfg05                |Off           |Off           |
      |viewMarkerCnfg06              |viewMarkerCnfg06                |Off           |Off           |
      |viewTraceCnfg01              |viewTraceCnfg01   |Off           |Off           |
      |viewTraceCnfg02              |viewTraceCnfg02   |Off           |Off           |
      |viewTraceCnfg03              |viewTraceCnfg03   |Off           |Off           |
      |viewTraceCnfg04              |viewTraceCnfg04   |Off           |Off           |
      |viewTraceCnfg05              |viewTraceCnfg05   |Off           |Off           |
      |viewTraceCnfg06              |viewTraceCnfg06   |Off           |Off           |

#######################################################################################################################
  Scenario Outline: onTraceDeltaMarkerCnfg01 test when set typeMarker
    When I change <id> value to <inputValue>.
    Then I make sure that <targetid> value is equal to <expectValue>.

    Examples:
      |id                            |targetid     |inputValue   |expectValue    |
      |typeTraceCnfg01              |typeTraceCnfg01   |ClearWrite           |ClearWrite           |
      |viewMarkerCnfg01              |viewMarkerCnfg01                |On           |On           |
      |selectTraceCnfg              |selectTraceCnfg                  |Trace01      |Trace01      |
      |typeMarkerCnfg01              |typeMarkerCnfg01                |Delta        |Delta        |
      |selectMarkerCnfg              |onTraceDeltaMarkerCnfg01  |Marker01           |Trace01           |
      |typeTraceCnfg02              |typeTraceCnfg02   |ClearWrite           |ClearWrite           |
      |viewMarkerCnfg02              |viewMarkerCnfg02                |On           |On           |
      |selectTraceCnfg              |selectTraceCnfg                  |Trace02      |Trace02      |
      |typeMarkerCnfg02              |typeMarkerCnfg02                |Delta        |Delta        |
      |selectMarkerCnfg              |onTraceDeltaMarkerCnfg02  |Marker02           |Trace02           |
      |typeTraceCnfg03              |typeTraceCnfg03   |ClearWrite           |ClearWrite           |
      |viewMarkerCnfg03              |viewMarkerCnfg03                |On           |On           |
      |selectTraceCnfg              |selectTraceCnfg                  |Trace03      |Trace03      |
      |typeMarkerCnfg03              |typeMarkerCnfg03                |Delta        |Delta        |
      |selectMarkerCnfg              |onTraceDeltaMarkerCnfg03  |Marker03           |Trace03           |
      |typeTraceCnfg04              |typeTraceCnfg04   |ClearWrite           |ClearWrite           |
      |viewMarkerCnfg04              |viewMarkerCnfg04                |On           |On           |
      |selectTraceCnfg              |selectTraceCnfg                  |Trace04      |Trace04      |
      |typeMarkerCnfg04              |typeMarkerCnfg04                |Delta        |Delta        |
      |selectMarkerCnfg              |onTraceDeltaMarkerCnfg04  |Marker04           |Trace04           |
      |typeTraceCnfg05              |typeTraceCnfg05   |ClearWrite           |ClearWrite           |
      |viewMarkerCnfg05              |viewMarkerCnfg05                |On           |On           |
      |selectTraceCnfg              |selectTraceCnfg                  |Trace05      |Trace05      |
      |typeMarkerCnfg05              |typeMarkerCnfg05                |Delta        |Delta        |
      |selectMarkerCnfg              |onTraceDeltaMarkerCnfg05  |Marker05           |Trace05           |
      |typeTraceCnfg06              |typeTraceCnfg06   |ClearWrite           |ClearWrite           |
      |viewMarkerCnfg06              |viewMarkerCnfg06                |On           |On           |
      |selectTraceCnfg              |selectTraceCnfg                  |Trace06      |Trace06      |
      |typeMarkerCnfg06              |typeMarkerCnfg06                |Delta        |Delta        |
      |selectMarkerCnfg              |onTraceDeltaMarkerCnfg06  |Marker06           |Trace06           |
      |selectTraceCnfg              |selectTraceCnfg  |Trace01           |Trace01           |
      |selectMarkerCnfg             |selectMarkerCnfg   |Marker01         |Marker01           |
      |viewMarkerCnfg01              |viewMarkerCnfg01                |Off           |Off           |
      |viewMarkerCnfg02              |viewMarkerCnfg02                |Off           |Off           |
      |viewMarkerCnfg03              |viewMarkerCnfg03                |Off           |Off           |
      |viewMarkerCnfg04              |viewMarkerCnfg04                |Off           |Off           |
      |viewMarkerCnfg05              |viewMarkerCnfg05                |Off           |Off           |
      |viewMarkerCnfg06              |viewMarkerCnfg06                |Off           |Off           |
      |viewTraceCnfg01              |viewTraceCnfg01   |Off           |Off           |
      |viewTraceCnfg02              |viewTraceCnfg02   |Off           |Off           |
      |viewTraceCnfg03              |viewTraceCnfg03   |Off           |Off           |
      |viewTraceCnfg04              |viewTraceCnfg04   |Off           |Off           |
      |viewTraceCnfg05              |viewTraceCnfg05   |Off           |Off           |
      |viewTraceCnfg06              |viewTraceCnfg06   |Off           |Off           |

#######################################################################################################################
  Scenario Outline: viewMarkerDataChannelCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |viewMarkerDataChannelCnfg              |On           |On           |
      |viewMarkerDataChannelCnfg              |Off           |Off           |
      |viewMarkerDataChannelCnfg              |On           |On           |

#######################################################################################################################
  Scenario Outline: numberRBDataChannelCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <targetid> value is equal to <expectValue>.

    Examples:
      |id                             |targetid    |inputValue   |expectValue    |
      |bandwidthCnfg                  |bandwidthCnfg                     |Bandwidth20           |Bandwidth20           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg          |-1           |0           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |0           |0           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |1           |1           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |98           |98           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |99           |99           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |100           |99           |
      |bandwidthCnfg                   |numberRBDataChannelCnfg  |Bandwidth15           |74           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg          |-1           |0           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |0           |0           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |1           |1           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |73           |73           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |74           |74           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |75           |74           |

      |bandwidthCnfg                   |numberRBDataChannelCnfg  |Bandwidth10           |49           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg          |-1           |0           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |0           |0           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |1           |1           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |48           |48           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |49           |49           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |50           |49           |

      |bandwidthCnfg                   |numberRBDataChannelCnfg  |Bandwidth5           |24           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg          |-1           |0           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |0           |0           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |1           |1           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |23           |23           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |24           |24           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |25           |24           |

      |bandwidthCnfg                   |numberRBDataChannelCnfg  |Bandwidth3           |14           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg          |-1           |0           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |0           |0           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |1           |1           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |13           |13           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |14           |14           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |15           |14           |

      |bandwidthCnfg                   |numberRBDataChannelCnfg  |Bandwidth14           |5           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg          |-1           |0           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |0           |0           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |1           |1           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |4           |4           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |5           |5           |
      |numberRBDataChannelCnfg        |numberRBDataChannelCnfg      |6           |5           |

 #######################################################################################################################
    Scenario Outline: viewMarkerControlChannelCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |viewMarkerControlChannelCnfg              |On           |On           |
      |viewMarkerControlChannelCnfg              |Off           |Off           |
      |viewMarkerControlChannelCnfg              |On           |On           |

#######################################################################################################################
  Scenario Outline: selectControlChannelCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeMBMSCnfg                       |Off          |Off            |
      |selectControlChannelCnfg              |PSS           |PSS           |
      |selectControlChannelCnfg              |SSS           |SSS           |
      |selectControlChannelCnfg              |PBCH           |PBCH           |
      |selectControlChannelCnfg              |PCFICH           |PCFICH           |
      |selectControlChannelCnfg              |PHICH           |PHICH           |
      |selectControlChannelCnfg              |PDCCH           |PDCCH           |
      |selectControlChannelCnfg              |RS0           |PSS           |
      |selectControlChannelCnfg              |RS1           |PSS           |
      |selectControlChannelCnfg              |RS2           |PSS           |
      |selectControlChannelCnfg              |RS3           |PSS           |
      |selectControlChannelCnfg              |MBSFNRS           |PSS           |
      |selectControlChannelCnfg              |PSS           |PSS           |

      |modeMBMSCnfg                       |On          |On            |
      |selectControlChannelCnfg              |PSS           |PSS           |
      |selectControlChannelCnfg              |SSS           |SSS           |
      |selectControlChannelCnfg              |PBCH           |PBCH           |
      |selectControlChannelCnfg              |PCFICH           |PCFICH           |
      |selectControlChannelCnfg              |PHICH           |PHICH           |
      |selectControlChannelCnfg              |PDCCH           |PDCCH           |
      |selectControlChannelCnfg              |RS0           |PSS           |
      |selectControlChannelCnfg              |RS1           |PSS           |
      |selectControlChannelCnfg              |RS2           |PSS           |
      |selectControlChannelCnfg              |RS3           |PSS           |
      |selectControlChannelCnfg              |MBSFNRS           |MBSFNRS           |
      |selectControlChannelCnfg              |PSS           |PSS           |

#######################################################################################################################
  Scenario Outline: selectControlChannelCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeMIMOCnfg                       |2x2          |2x2            |
      |selectControlChannelCnfg              |PSS           |PSS           |
      |selectControlChannelCnfg              |SSS           |SSS           |
      |selectControlChannelCnfg              |PBCH           |PBCH           |
      |selectControlChannelCnfg              |PCFICH           |PCFICH           |
      |selectControlChannelCnfg              |RS0           |RS0           |
      |selectControlChannelCnfg              |RS1           |RS1           |
      |selectControlChannelCnfg              |RS2           |PSS           |
      |selectControlChannelCnfg              |RS3           |PSS           |
      |selectControlChannelCnfg              |PSS           |PSS           |

      |modeMIMOCnfg                       |4x4          |4x4            |
      |selectControlChannelCnfg              |PSS           |PSS           |
      |selectControlChannelCnfg              |SSS           |SSS           |
      |selectControlChannelCnfg              |PBCH           |PBCH           |
      |selectControlChannelCnfg              |PCFICH           |PCFICH           |
      |selectControlChannelCnfg              |RS0           |RS0           |
      |selectControlChannelCnfg              |RS1           |RS1           |
      |selectControlChannelCnfg              |RS2           |RS2           |
      |selectControlChannelCnfg              |RS3           |RS3           |
      |selectControlChannelCnfg              |PSS           |PSS           |

#######################################################################################################################
  Scenario Outline: viewMarkerSubframeCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |viewMarkerSubframeCnfg              |On           |On           |
      |viewMarkerSubframeCnfg              |Off           |Off           |
      |viewMarkerSubframeCnfg              |On           |On           |

#######################################################################################################################

  Scenario Outline: selectSymbolCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <targetid> value is equal to <expectValue>.

    Examples:
      |id                             |targetid    |inputValue   |expectValue    |
      |selectSymbolCnfg        |selectSymbolCnfg      |-1           |0           |
      |selectSymbolCnfg        |selectSymbolCnfg      |0           |0           |
      |selectSymbolCnfg        |selectSymbolCnfg      |1           |1           |
      |selectSymbolCnfg        |selectSymbolCnfg      |12           |12           |
      |selectSymbolCnfg        |selectSymbolCnfg      |13           |13           |
      |selectSymbolCnfg        |selectSymbolCnfg      |14           |13           |

#######################################################################################################################
  Scenario Outline: viewMarkerDataAllocMapCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |viewMarkerDataAllocMapCnfg              |On           |On           |
      |viewMarkerDataAllocMapCnfg              |Off           |Off           |
      |viewMarkerDataAllocMapCnfg              |On           |On           |

#######################################################################################################################
  Scenario Outline: numberRBDataAllocMapCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <targetid> value is equal to <expectValue>.

    Examples:
      |id                             |targetid    |inputValue   |expectValue    |
      |bandwidthCnfg                  |bandwidthCnfg                     |Bandwidth20           |Bandwidth20           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg          |-1           |0           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |0           |0           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |1           |1           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |98           |98           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |99           |99           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |100           |99           |

      |bandwidthCnfg                   |numberRBDataAllocMapCnfg  |Bandwidth15           |74           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg          |-1           |0           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |0           |0           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |1           |1           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |73           |73           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |74           |74           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |75           |74           |

      |bandwidthCnfg                   |numberRBDataAllocMapCnfg  |Bandwidth10           |49           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg          |-1           |0           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |0           |0           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |1           |1           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |48           |48           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |49           |49           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |50           |49           |

      |bandwidthCnfg                   |numberRBDataAllocMapCnfg  |Bandwidth5           |24           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg          |-1           |0           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |0           |0           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |1           |1           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |23           |23           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |24           |24           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |25           |24           |

      |bandwidthCnfg                   |numberRBDataAllocMapCnfg  |Bandwidth3           |14           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg          |-1           |0           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |0           |0           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |1           |1           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |13           |13           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |14           |14           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |15           |14           |

      |bandwidthCnfg                   |numberRBDataAllocMapCnfg  |Bandwidth14           |5           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg          |-1           |0           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |0           |0           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |1           |1           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |4           |4           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |5           |5           |
      |numberRBDataAllocMapCnfg        |numberRBDataAllocMapCnfg      |6           |5           |

#######################################################################################################################
  Scenario Outline: selectNumberSubframeCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <targetid> value is equal to <expectValue>.

    Examples:
      |id                             |targetid    |inputValue   |expectValue    |
      |selectNumberSubframeCnfg        |selectNumberSubframeCnfg          |-1           |0           |
      |selectNumberSubframeCnfg        |selectNumberSubframeCnfg      |0           |0           |
      |selectNumberSubframeCnfg        |selectNumberSubframeCnfg      |1           |1           |
      |selectNumberSubframeCnfg        |selectNumberSubframeCnfg      |8           |8           |
      |selectNumberSubframeCnfg        |selectNumberSubframeCnfg      |9           |9           |
      |selectNumberSubframeCnfg        |selectNumberSubframeCnfg      |10           |9           |

#######################################################################################################################
  Scenario Outline: viewMarkerCACnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |viewMarkerCACnfg              |On           |On           |
      |viewMarkerCACnfg              |Off           |Off           |
      |viewMarkerCACnfg              |On           |On           |
      |viewMarkerCACnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: selectChannelEVMSingleCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |selectChannelEVMSingleCnfg              |PSS           |PSS           |
      |selectChannelEVMSingleCnfg              |SSS           |SSS           |
      |selectChannelEVMSingleCnfg              |PBCH           |PBCH           |
      |selectChannelEVMSingleCnfg              |RS           |RS           |
      |selectChannelEVMSingleCnfg              |PDSCHQPSK           |PDSCHQPSK           |
      |selectChannelEVMSingleCnfg              |PDSCH16QAM           |PDSCH16QAM           |
      |selectChannelEVMSingleCnfg              |PDSCH64QAM           |PDSCH64QAM           |
      |selectChannelEVMSingleCnfg              |PSS           |PSS           |

#######################################################################################################################
  Scenario Outline: selectChannelEVMCombineCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeMIMOCnfg                       |2x2          |2x2            |
      |selectChannelEVMCombineCnfg              |PSS           |PSS           |
      |selectChannelEVMCombineCnfg              |SSS           |SSS           |
      |selectChannelEVMCombineCnfg              |PBCH           |PBCH           |
      |selectChannelEVMCombineCnfg              |PCFICH           |PCFICH           |
      |selectChannelEVMCombineCnfg              |RS0           |RS0           |
      |selectChannelEVMCombineCnfg              |RS1           |RS1           |
      |selectChannelEVMCombineCnfg              |RS2           |PSS           |
      |selectChannelEVMCombineCnfg              |RS3           |PSS           |
      |selectChannelEVMCombineCnfg              |PSS           |PSS           |

      |modeMIMOCnfg                       |4x4          |4x4            |
      |selectChannelEVMCombineCnfg              |PSS           |PSS           |
      |selectChannelEVMCombineCnfg              |SSS           |SSS           |
      |selectChannelEVMCombineCnfg              |PBCH           |PBCH           |
      |selectChannelEVMCombineCnfg              |PCFICH           |PCFICH           |
      |selectChannelEVMCombineCnfg              |RS0           |RS0           |
      |selectChannelEVMCombineCnfg              |RS1           |RS1           |
      |selectChannelEVMCombineCnfg              |RS2           |RS2           |
      |selectChannelEVMCombineCnfg              |RS3           |RS3           |
      |selectChannelEVMCombineCnfg              |PSS           |PSS           |

#######################################################################################################################
  Scenario Outline: numberRBDatagramCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <targetid> value is equal to <expectValue>.

    Examples:
      |id                             |targetid    |inputValue   |expectValue    |
      |bandwidthCnfg                  |bandwidthCnfg                     |Bandwidth20           |Bandwidth20           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg          |-1           |0           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |0           |0           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |1           |1           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |98           |98           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |99           |99           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |100           |99           |

      |bandwidthCnfg                   |numberRBDatagramCnfg  |Bandwidth15           |74           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg          |-1           |0           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |0           |0           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |1           |1           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |73           |73           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |74           |74           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |75           |74           |

      |bandwidthCnfg                   |numberRBDatagramCnfg  |Bandwidth10           |49           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg          |-1           |0           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |0           |0           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |1           |1           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |48           |48           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |49           |49           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |50           |49           |

      |bandwidthCnfg                   |numberRBDatagramCnfg  |Bandwidth5           |24           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg          |-1           |0           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |0           |0           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |1           |1           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |23           |23           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |24           |24           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |25           |24           |

      |bandwidthCnfg                   |numberRBDatagramCnfg  |Bandwidth3           |14           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg          |-1           |0           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |0           |0           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |1           |1           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |13           |13           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |14           |14           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |15           |14           |

      |bandwidthCnfg                   |numberRBDatagramCnfg  |Bandwidth14           |5           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg          |-1           |0           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |0           |0           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |1           |1           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |4           |4           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |5           |5           |
      |numberRBDatagramCnfg        |numberRBDatagramCnfg      |6           |5           |

#######################################################################################################################

  Scenario Outline: modeSweepCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeSweepCnfg                                       |Continue           |Continue           |
      |modeSweepCnfg                                       |Single           |Single           |
#######################################################################################################################
  Scenario Outline: modeTriggerCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeTriggerCnfg                                       |Internal           |Internal           |
      |modeTriggerCnfg                                       |External           |External           |
      |modeTriggerCnfg                                       |GPS           |GPS           |
      |modeTriggerCnfg                                       |Internal           |Internal           |
      |modeTriggerCnfg                                       |asd           |Internal           |

#######################################################################################################################

  Scenario Outline: lengthCCDFCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |lengthCCDFCnfg                                       |-1           |0           |
      |lengthCCDFCnfg                                       |0           |0           |
      |lengthCCDFCnfg                                       |1           |1           |
      |lengthCCDFCnfg                                       |99           |99           |
      |lengthCCDFCnfg                                       |100           |100           |
      |lengthCCDFCnfg                                       |101           |100           |

#######################################################################################################################

  Scenario Outline: numberSubframeCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |numberSubframeCnfg                                       |-1           |0           |
      |numberSubframeCnfg                                       |0           |0           |
      |numberSubframeCnfg                                       |1           |1           |
      |numberSubframeCnfg                                       |8           |8           |
      |numberSubframeCnfg                                       |9           |9           |
      |numberSubframeCnfg                                       |10           |9           |

#######################################################################################################################

  Scenario Outline: numberSlotCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |numberSlotCnfg                                       |-1           |0           |
      |numberSlotCnfg                                       |0           |0           |
      |numberSlotCnfg                                       |1           |1           |
      |numberSlotCnfg                                       |18           |18           |
      |numberSlotCnfg                                       |19           |19           |
      |numberSlotCnfg                                       |20           |19           |

#######################################################################################################################
  Scenario Outline: modeMIMOCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeMIMOCnfg                                       |2x2           |2x2           |
      |modeMIMOCnfg                                       |4x4           |4x4           |
      |modeMIMOCnfg                                       |2x2           |2x2           |
      |modeMIMOCnfg                                       |asd           |2x2           |

#######################################################################################################################
  Scenario Outline: modeEVMDetectCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeEVMDetectCnfg                                       |Single           |Single           |
      |modeEVMDetectCnfg                                       |Combine           |Combine           |
      |modeEVMDetectCnfg                                       |Single           |Single           |
      |modeEVMDetectCnfg                                       |asd           |Single           |

#######################################################################################################################
  Scenario Outline: numberCellIDCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |numberCellIDCnfg                |-1           |0           |
      |numberCellIDCnfg                |0           |0           |
      |numberCellIDCnfg                |1           |1           |
      |numberCellIDCnfg                |502           |502           |
      |numberCellIDCnfg                |503           |503           |
      |numberCellIDCnfg                |504           |503           |

#######################################################################################################################
  Scenario Outline: modeCellIDCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeCellIDCnfg                |Auto           |Auto           |
      |modeCellIDCnfg                |Manual           |Manual           |
      |modeCellIDCnfg                |Auto           |Auto           |
      |modeCellIDCnfg                |asd           |Auto           |

#######################################################################################################################
  Scenario Outline: selectAntennaCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |selectAntennaCnfg                |Auto           |Auto           |
      |selectAntennaCnfg                |Antenna0           |Antenna0           |
      |selectAntennaCnfg                |Antenna1           |Antenna1           |
      |selectAntennaCnfg                |Antenna2           |Antenna2           |
      |selectAntennaCnfg                |Antenna3           |Antenna3           |
      |selectAntennaCnfg                |Auto           |Auto           |
      |selectAntennaCnfg                |asd           |Auto           |

#######################################################################################################################
  Scenario Outline: modeCyclicCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeCyclicCnfg                |Normal           |Normal           |
      |modeCyclicCnfg                |Extended           |Extended           |
      |modeCyclicCnfg                |Normal           |Normal           |
      |modeCyclicCnfg                |asd           |Normal           |

#######################################################################################################################
  Scenario Outline: numberCFICnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |numberCFICnfg                |-2           |-1           |
      |numberCFICnfg                |-1           |-1           |
      |numberCFICnfg                |0           |0           |
      |numberCFICnfg                |1           |1           |
      |numberCFICnfg                |2           |2           |
      |numberCFICnfg                |3           |3           |
      |numberCFICnfg                |4           |3           |

#######################################################################################################################
  Scenario Outline: modeCFICnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeCFICnfg                |Auto           |Auto           |
      |modeCFICnfg                |Manual           |Manual           |
      |modeCFICnfg                |Auto           |Auto           |
      |modeCFICnfg                |asd           |Auto           |

#######################################################################################################################
  Scenario Outline: holdEvenCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |holdEvenCnfg              |On           |On           |
      |holdEvenCnfg              |Off           |Off           |
      |holdEvenCnfg              |On           |On           |
      |holdEvenCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modePHICHNgCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modePHICHNgCnfg              |1/6           |1/6           |
      |modePHICHNgCnfg              |1/2           |1/2           |
      |modePHICHNgCnfg              |1           |1           |
      |modePHICHNgCnfg              |2           |2           |
      |modePHICHNgCnfg              |E-1/6           |E-1/6           |
      |modePHICHNgCnfg              |E-1/2           |E-1/2           |
      |modePHICHNgCnfg              |E-1           |E-1           |
      |modePHICHNgCnfg              |E-2           |E-2           |
      |modePHICHNgCnfg              |1/6           |1/6           |
      |modePHICHNgCnfg              |asd           |1/6           |

#######################################################################################################################
  Scenario Outline: modeMBMSCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeMBMSCnfg              |On           |On           |
      |modeMBMSCnfg              |Off           |Off           |
      |modeMBMSCnfg              |On           |On           |
      |modeMBMSCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modeMBSFNCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeMBSFNCnfg                |Auto           |Auto           |
      |modeMBSFNCnfg                |Manual           |Manual           |
      |modeMBSFNCnfg                |Auto           |Auto           |
      |modeMBSFNCnfg                |asd           |Auto           |

#######################################################################################################################
  Scenario Outline: numberMBSFNCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeMBSFNCnfg                |Auto           |Auto           |
      |numberMBSFNCnfg                |-1           |0           |
      |numberMBSFNCnfg                |0           |0           |
      |numberMBSFNCnfg                |1           |1           |
      |numberMBSFNCnfg                |254           |254           |
      |numberMBSFNCnfg                |255           |255           |
      |numberMBSFNCnfg                |256           |256           |
      |numberMBSFNCnfg                |257           |256           |
      |modeMBSFNCnfg                |Manual           |Manual           |
      |numberMBSFNCnfg                |-1           |0           |
      |numberMBSFNCnfg                |0           |0           |
      |numberMBSFNCnfg                |1           |1           |
      |numberMBSFNCnfg                |254           |254           |
      |numberMBSFNCnfg                |255           |255           |
      |numberMBSFNCnfg                |256           |255           |
      |numberMBSFNCnfg                |257           |255           |

#######################################################################################################################
  Scenario Outline: typePDSCHCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |typePDSCHCnfg                |Auto           |Auto           |
      |typePDSCHCnfg                |QPSK           |QPSK           |
      |typePDSCHCnfg                |16QAM           |16QAM           |
      |typePDSCHCnfg                |64QAM           |64QAM           |
      |typePDSCHCnfg                |256QAM           |256QAM           |
      |typePDSCHCnfg                |E-TM3.3           |E-TM3.3           |
      |typePDSCHCnfg                |E-TM3.2           |E-TM3.2           |
      |typePDSCHCnfg                |E-TM3.1a           |E-TM3.1a           |
      |typePDSCHCnfg                |E-TM3.1           |E-TM3.1           |
      |typePDSCHCnfg                |E-TM2a           |E-TM2a           |
      |typePDSCHCnfg                |E-TM2           |E-TM2           |
      |typePDSCHCnfg                |E-TM1.2           |E-TM1.2           |
      |typePDSCHCnfg                |E-TM1.1           |E-TM1.1           |

#######################################################################################################################
  Scenario Outline: thresholdPDSCHCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |thresholdPDSCHCnfg                |-200.1           |-200           |
      |thresholdPDSCHCnfg                |-200           |-200           |
      |thresholdPDSCHCnfg                |-199.9           |-199.9           |
      |thresholdPDSCHCnfg                |199.9           |199.9           |
      |thresholdPDSCHCnfg                |200           |200           |
      |thresholdPDSCHCnfg                |200.1           |200           |

#######################################################################################################################
  Scenario Outline: thresholdPDCCHCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |thresholdPDCCHCnfg                |-200.1           |-200           |
      |thresholdPDCCHCnfg                |-200           |-200           |
      |thresholdPDCCHCnfg                |-199.9           |-199.9           |
      |thresholdPDCCHCnfg                |199.9           |199.9           |
      |thresholdPDCCHCnfg                |200           |200           |
      |thresholdPDCCHCnfg                |200.1           |200           |

#######################################################################################################################
  Scenario Outline: precodingPDSCHCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |precodingPDSCHCnfg              |On           |On           |
      |precodingPDSCHCnfg              |Off           |Off           |
      |precodingPDSCHCnfg              |On           |On           |
      |precodingPDSCHCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modePDCCHCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modePDCCHCnfg              |REG           |REG           |
      |modePDCCHCnfg              |Average           |Average           |
      |modePDCCHCnfg              |REG           |REG           |
      |modePDCCHCnfg              |asd           |REG           |

#######################################################################################################################
  Scenario Outline: methodMultipleCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |methodMultipleCnfg              |-1           |0           |
      |methodMultipleCnfg              |0           |0           |
      |methodMultipleCnfg              |1           |1           |
      |methodMultipleCnfg              |99           |99           |
      |methodMultipleCnfg              |100           |100           |
      |methodMultipleCnfg              |101           |100           |

#######################################################################################################################
  Scenario Outline: displayReferenceCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |displayReferenceCnfg              |RS           |RS           |
      |displayReferenceCnfg              |Sync           |Sync           |
      |displayReferenceCnfg              |RS           |RS           |
      |displayReferenceCnfg              |asd           |RS           |

#######################################################################################################################
  Scenario Outline: selectRSWindowCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |selectRSWindowCnfg              |2us           |2us           |
      |selectRSWindowCnfg              |4us           |4us           |
      |selectRSWindowCnfg              |8us           |8us           |
      |selectRSWindowCnfg              |2us           |2us           |
      |selectRSWindowCnfg              |asd           |2us           |

#######################################################################################################################
  Scenario Outline: cursorTimeCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |cursorTimeCnfg              |On           |On           |
      |cursorTimeCnfg              |Off           |Off           |
      |cursorTimeCnfg              |On           |On           |
      |cursorTimeCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: selectPositionCnfg test
    When I change measurementModeCnfg value to otaDatagram.
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |selectPositionCnfg              |-1           |0           |
      |selectPositionCnfg              |0           |0           |
      |selectPositionCnfg              |1           |1           |
      |selectPositionCnfg              |5           |5           |
      |selectPositionCnfg              |10           |10           |
      |selectPositionCnfg              |20           |20           |

#######################################################################################################################
  Scenario Outline: modePlotRouteMapCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modePlotRouteMapCnfg              |Stop           |Stop           |
      |modePlotRouteMapCnfg              |Start           |Start           |
      |modePlotRouteMapCnfg              |Stop           |Stop           |
      |modePlotRouteMapCnfg              |asd           |Stop           |

#######################################################################################################################
  Scenario Outline: typePlotRouteMapCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |typePlotRouteMapCnfg              |GPS           |GPS           |
      |typePlotRouteMapCnfg              |Position           |Position           |
      |typePlotRouteMapCnfg              |GPS           |GPS           |
      |typePlotRouteMapCnfg              |asd           |GPS           |

#######################################################################################################################
  Scenario Outline: itemPlotRouteMapCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |itemPlotRouteMapCnfg              |RSRP           |RSRP           |
      |itemPlotRouteMapCnfg              |RSRQ           |RSRQ           |
      |itemPlotRouteMapCnfg              |RSSINR           |RSSINR           |
      |itemPlotRouteMapCnfg              |SSSRSSI           |SSSRSSI           |
      |itemPlotRouteMapCnfg              |PSSPower           |PSSPower           |
      |itemPlotRouteMapCnfg              |SSSPower           |SSSPower           |
      |itemPlotRouteMapCnfg              |SSSEcIo           |SSSEcIo           |
      |itemPlotRouteMapCnfg              |RSRP           |RSRP           |
      |itemPlotRouteMapCnfg              |asd           |RSRP           |

#######################################################################################################################
  Scenario Outline: screenTypeRouteMapCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |screenTypeRouteMapCnfg              |Map           |Map           |
      |screenTypeRouteMapCnfg              |Full           |Full           |
      |screenTypeRouteMapCnfg              |Map           |Map           |
      |screenTypeRouteMapCnfg              |asd           |Map           |

#######################################################################################################################
  Scenario Outline: indexRouteMapRSRPCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                |targetid     |inputValue   |expectValue    |
      |indexRouteMapRSRPCnfgPoor      |indexRouteMapRSRPCnfgPoor        |-100          |-100           |
      |indexRouteMapRSRPCnfgFair      |indexRouteMapRSRPCnfgFair        |-95           |-95           |
      |indexRouteMapRSRPCnfgGood      |indexRouteMapRSRPCnfgGood        |-90           |-90           |
      |indexRouteMapRSRPCnfgVery      |indexRouteMapRSRPCnfgVery        |-80           |-80           |
      |indexRouteMapRSRPCnfgExec      |indexRouteMapRSRPCnfgExec        |-70           |-70           |

      |indexRouteMapRSRPCnfgPoor      |indexRouteMapRSRPCnfgFair        |-50          |-50           |
      |indexRouteMapRSRPCnfgPoor      |indexRouteMapRSRPCnfgGood        |-50          |-50           |
      |indexRouteMapRSRPCnfgPoor      |indexRouteMapRSRPCnfgVery        |-50          |-50           |
      |indexRouteMapRSRPCnfgPoor      |indexRouteMapRSRPCnfgExec        |-50          |-50           |

      |indexRouteMapRSRPCnfgPoor      |indexRouteMapRSRPCnfgPoor        |-100          |-100           |
      |indexRouteMapRSRPCnfgFair      |indexRouteMapRSRPCnfgFair        |-95           |-95           |
      |indexRouteMapRSRPCnfgGood      |indexRouteMapRSRPCnfgGood        |-90           |-90           |
      |indexRouteMapRSRPCnfgVery      |indexRouteMapRSRPCnfgVery        |-80           |-80           |
      |indexRouteMapRSRPCnfgExec      |indexRouteMapRSRPCnfgExec        |-70           |-70           |

      |indexRouteMapRSRPCnfgFair      |indexRouteMapRSRPCnfgGood        |-50          |-50           |
      |indexRouteMapRSRPCnfgFair      |indexRouteMapRSRPCnfgVery        |-50          |-50           |
      |indexRouteMapRSRPCnfgFair      |indexRouteMapRSRPCnfgExec        |-50          |-50           |

      |indexRouteMapRSRPCnfgPoor      |indexRouteMapRSRPCnfgPoor        |-100          |-100           |
      |indexRouteMapRSRPCnfgFair      |indexRouteMapRSRPCnfgFair        |-95           |-95           |
      |indexRouteMapRSRPCnfgGood      |indexRouteMapRSRPCnfgGood        |-90           |-90           |
      |indexRouteMapRSRPCnfgVery      |indexRouteMapRSRPCnfgVery        |-80           |-80           |
      |indexRouteMapRSRPCnfgExec      |indexRouteMapRSRPCnfgExec        |-70           |-70           |

      |indexRouteMapRSRPCnfgGood      |indexRouteMapRSRPCnfgVery        |-50          |-50           |
      |indexRouteMapRSRPCnfgGood      |indexRouteMapRSRPCnfgExec        |-50          |-50           |

      |indexRouteMapRSRPCnfgPoor      |indexRouteMapRSRPCnfgPoor        |-100          |-100           |
      |indexRouteMapRSRPCnfgFair      |indexRouteMapRSRPCnfgFair        |-95           |-95           |
      |indexRouteMapRSRPCnfgGood      |indexRouteMapRSRPCnfgGood        |-90           |-90           |
      |indexRouteMapRSRPCnfgVery      |indexRouteMapRSRPCnfgVery        |-80           |-80           |
      |indexRouteMapRSRPCnfgExec      |indexRouteMapRSRPCnfgExec        |-70           |-70           |

      |indexRouteMapRSRPCnfgVery      |indexRouteMapRSRPCnfgExec        |-50          |-50           |

      |indexRouteMapRSRPCnfgPoor      |indexRouteMapRSRPCnfgPoor        |-100          |-100           |
      |indexRouteMapRSRPCnfgFair      |indexRouteMapRSRPCnfgFair        |-95           |-95           |
      |indexRouteMapRSRPCnfgGood      |indexRouteMapRSRPCnfgGood        |-90           |-90           |
      |indexRouteMapRSRPCnfgVery      |indexRouteMapRSRPCnfgVery        |-80           |-80           |
      |indexRouteMapRSRPCnfgExec      |indexRouteMapRSRPCnfgExec        |-70           |-70           |

      |indexRouteMapRSRPCnfgExec      |indexRouteMapRSRPCnfgVery        |-110           |-110           |
      |indexRouteMapRSRPCnfgExec      |indexRouteMapRSRPCnfgGood        |-110           |-110           |
      |indexRouteMapRSRPCnfgExec      |indexRouteMapRSRPCnfgFair        |-110           |-110           |
      |indexRouteMapRSRPCnfgExec      |indexRouteMapRSRPCnfgPoor        |-110           |-110           |

      |indexRouteMapRSRPCnfgPoor      |indexRouteMapRSRPCnfgPoor        |-100          |-100           |
      |indexRouteMapRSRPCnfgFair      |indexRouteMapRSRPCnfgFair        |-95           |-95           |
      |indexRouteMapRSRPCnfgGood      |indexRouteMapRSRPCnfgGood        |-90           |-90           |
      |indexRouteMapRSRPCnfgVery      |indexRouteMapRSRPCnfgVery        |-80           |-80           |
      |indexRouteMapRSRPCnfgExec      |indexRouteMapRSRPCnfgExec        |-70           |-70           |

      |indexRouteMapRSRPCnfgVery      |indexRouteMapRSRPCnfgGood        |-110           |-110           |
      |indexRouteMapRSRPCnfgVery      |indexRouteMapRSRPCnfgFair        |-110           |-110           |
      |indexRouteMapRSRPCnfgVery      |indexRouteMapRSRPCnfgPoor        |-110           |-110           |

      |indexRouteMapRSRPCnfgPoor      |indexRouteMapRSRPCnfgPoor        |-100          |-100           |
      |indexRouteMapRSRPCnfgFair      |indexRouteMapRSRPCnfgFair        |-95           |-95           |
      |indexRouteMapRSRPCnfgGood      |indexRouteMapRSRPCnfgGood        |-90           |-90           |
      |indexRouteMapRSRPCnfgVery      |indexRouteMapRSRPCnfgVery        |-80           |-80           |
      |indexRouteMapRSRPCnfgExec      |indexRouteMapRSRPCnfgExec        |-70           |-70           |

      |indexRouteMapRSRPCnfgGood      |indexRouteMapRSRPCnfgFair        |-110           |-110           |
      |indexRouteMapRSRPCnfgGood      |indexRouteMapRSRPCnfgPoor        |-110           |-110           |

      |indexRouteMapRSRPCnfgPoor      |indexRouteMapRSRPCnfgPoor        |-100          |-100           |
      |indexRouteMapRSRPCnfgFair      |indexRouteMapRSRPCnfgFair        |-95           |-95           |
      |indexRouteMapRSRPCnfgGood      |indexRouteMapRSRPCnfgGood        |-90           |-90           |
      |indexRouteMapRSRPCnfgVery      |indexRouteMapRSRPCnfgVery        |-80           |-80           |
      |indexRouteMapRSRPCnfgExec      |indexRouteMapRSRPCnfgExec        |-70           |-70           |

      |indexRouteMapRSRPCnfgFair      |indexRouteMapRSRPCnfgPoor        |-110           |-110           |

#######################################################################################################################
  Scenario Outline: indexRouteMapRSRQCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                |targetid     |inputValue   |expectValue    |
      |indexRouteMapRSRQCnfgPoor      |indexRouteMapRSRQCnfgPoor        |-100          |-100           |
      |indexRouteMapRSRQCnfgFair      |indexRouteMapRSRQCnfgFair        |-95           |-95           |
      |indexRouteMapRSRQCnfgGood      |indexRouteMapRSRQCnfgGood        |-90           |-90           |

      |indexRouteMapRSRQCnfgPoor      |indexRouteMapRSRQCnfgFair        |-50          |-50           |
      |indexRouteMapRSRQCnfgPoor      |indexRouteMapRSRQCnfgGood        |-50          |-50           |

      |indexRouteMapRSRQCnfgPoor      |indexRouteMapRSRQCnfgPoor        |-100          |-100           |
      |indexRouteMapRSRQCnfgFair      |indexRouteMapRSRQCnfgFair        |-95           |-95           |
      |indexRouteMapRSRQCnfgGood      |indexRouteMapRSRQCnfgGood        |-90           |-90           |

      |indexRouteMapRSRQCnfgFair      |indexRouteMapRSRQCnfgGood        |-50          |-50           |

      |indexRouteMapRSRQCnfgPoor      |indexRouteMapRSRQCnfgPoor        |-100          |-100           |
      |indexRouteMapRSRQCnfgFair      |indexRouteMapRSRQCnfgFair        |-95           |-95           |
      |indexRouteMapRSRQCnfgGood      |indexRouteMapRSRQCnfgGood        |-90           |-90           |

      |indexRouteMapRSRQCnfgPoor      |indexRouteMapRSRQCnfgPoor        |-100          |-100           |
      |indexRouteMapRSRQCnfgFair      |indexRouteMapRSRQCnfgFair        |-95           |-95           |
      |indexRouteMapRSRQCnfgGood      |indexRouteMapRSRQCnfgGood        |-90           |-90           |

      |indexRouteMapRSRQCnfgPoor      |indexRouteMapRSRQCnfgPoor        |-100          |-100           |
      |indexRouteMapRSRQCnfgFair      |indexRouteMapRSRQCnfgFair        |-95           |-95           |
      |indexRouteMapRSRQCnfgGood      |indexRouteMapRSRQCnfgGood        |-90           |-90           |

      |indexRouteMapRSRQCnfgGood      |indexRouteMapRSRQCnfgFair        |-110           |-110           |
      |indexRouteMapRSRQCnfgGood      |indexRouteMapRSRQCnfgPoor        |-110           |-110           |

      |indexRouteMapRSRQCnfgPoor      |indexRouteMapRSRQCnfgPoor        |-100          |-100           |
      |indexRouteMapRSRQCnfgFair      |indexRouteMapRSRQCnfgFair        |-95           |-95           |
      |indexRouteMapRSRQCnfgGood      |indexRouteMapRSRQCnfgGood        |-90           |-90           |

      |indexRouteMapRSRQCnfgFair      |indexRouteMapRSRQCnfgPoor        |-110           |-110           |

#######################################################################################################################
  Scenario Outline: indexRouteMapRSSINRCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                |targetid     |inputValue   |expectValue    |
      |indexRouteMapRSSINRCnfgPoor      |indexRouteMapRSSINRCnfgPoor        |-100          |-100           |
      |indexRouteMapRSSINRCnfgFair      |indexRouteMapRSSINRCnfgFair        |-95           |-95           |
      |indexRouteMapRSSINRCnfgGood      |indexRouteMapRSSINRCnfgGood        |-90           |-90           |

      |indexRouteMapRSSINRCnfgPoor      |indexRouteMapRSSINRCnfgFair        |-50          |-50           |
      |indexRouteMapRSSINRCnfgPoor      |indexRouteMapRSSINRCnfgGood        |-50          |-50           |

      |indexRouteMapRSSINRCnfgPoor      |indexRouteMapRSSINRCnfgPoor        |-100          |-100           |
      |indexRouteMapRSSINRCnfgFair      |indexRouteMapRSSINRCnfgFair        |-95           |-95           |
      |indexRouteMapRSSINRCnfgGood      |indexRouteMapRSSINRCnfgGood        |-90           |-90           |

      |indexRouteMapRSSINRCnfgFair      |indexRouteMapRSSINRCnfgGood        |-50          |-50           |

      |indexRouteMapRSSINRCnfgPoor      |indexRouteMapRSSINRCnfgPoor        |-100          |-100           |
      |indexRouteMapRSSINRCnfgFair      |indexRouteMapRSSINRCnfgFair        |-95           |-95           |
      |indexRouteMapRSSINRCnfgGood      |indexRouteMapRSSINRCnfgGood        |-90           |-90           |

      |indexRouteMapRSSINRCnfgPoor      |indexRouteMapRSSINRCnfgPoor        |-100          |-100           |
      |indexRouteMapRSSINRCnfgFair      |indexRouteMapRSSINRCnfgFair        |-95           |-95           |
      |indexRouteMapRSSINRCnfgGood      |indexRouteMapRSSINRCnfgGood        |-90           |-90           |

      |indexRouteMapRSSINRCnfgPoor      |indexRouteMapRSSINRCnfgPoor        |-100          |-100           |
      |indexRouteMapRSSINRCnfgFair      |indexRouteMapRSSINRCnfgFair        |-95           |-95           |
      |indexRouteMapRSSINRCnfgGood      |indexRouteMapRSSINRCnfgGood        |-90           |-90           |

      |indexRouteMapRSSINRCnfgGood      |indexRouteMapRSSINRCnfgFair        |-110           |-110           |
      |indexRouteMapRSSINRCnfgGood      |indexRouteMapRSSINRCnfgPoor        |-110           |-110           |

      |indexRouteMapRSSINRCnfgPoor      |indexRouteMapRSSINRCnfgPoor        |-100          |-100           |
      |indexRouteMapRSSINRCnfgFair      |indexRouteMapRSSINRCnfgFair        |-95           |-95           |
      |indexRouteMapRSSINRCnfgGood      |indexRouteMapRSSINRCnfgGood        |-90           |-90           |

      |indexRouteMapRSSINRCnfgFair      |indexRouteMapRSSINRCnfgPoor        |-110           |-110           |

#######################################################################################################################
  Scenario Outline: indexRouteMapSSSRSSICnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                |targetid     |inputValue   |expectValue    |
      |indexRouteMapSSSRSSICnfgPoor      |indexRouteMapSSSRSSICnfgPoor        |-100          |-100           |
      |indexRouteMapSSSRSSICnfgFair      |indexRouteMapSSSRSSICnfgFair        |-95           |-95           |
      |indexRouteMapSSSRSSICnfgGood      |indexRouteMapSSSRSSICnfgGood        |-90           |-90           |
      |indexRouteMapSSSRSSICnfgVery      |indexRouteMapSSSRSSICnfgVery        |-80           |-80           |
      |indexRouteMapSSSRSSICnfgExec      |indexRouteMapSSSRSSICnfgExec        |-70           |-70           |

      |indexRouteMapSSSRSSICnfgPoor      |indexRouteMapSSSRSSICnfgFair        |-50          |-50           |
      |indexRouteMapSSSRSSICnfgPoor      |indexRouteMapSSSRSSICnfgGood        |-50          |-50           |
      |indexRouteMapSSSRSSICnfgPoor      |indexRouteMapSSSRSSICnfgVery        |-50          |-50           |
      |indexRouteMapSSSRSSICnfgPoor      |indexRouteMapSSSRSSICnfgExec        |-50          |-50           |

      |indexRouteMapSSSRSSICnfgPoor      |indexRouteMapSSSRSSICnfgPoor        |-100          |-100           |
      |indexRouteMapSSSRSSICnfgFair      |indexRouteMapSSSRSSICnfgFair        |-95           |-95           |
      |indexRouteMapSSSRSSICnfgGood      |indexRouteMapSSSRSSICnfgGood        |-90           |-90           |
      |indexRouteMapSSSRSSICnfgVery      |indexRouteMapSSSRSSICnfgVery        |-80           |-80           |
      |indexRouteMapSSSRSSICnfgExec      |indexRouteMapSSSRSSICnfgExec        |-70           |-70           |

      |indexRouteMapSSSRSSICnfgFair      |indexRouteMapSSSRSSICnfgGood        |-50          |-50           |
      |indexRouteMapSSSRSSICnfgFair      |indexRouteMapSSSRSSICnfgVery        |-50          |-50           |
      |indexRouteMapSSSRSSICnfgFair      |indexRouteMapSSSRSSICnfgExec        |-50          |-50           |

      |indexRouteMapSSSRSSICnfgPoor      |indexRouteMapSSSRSSICnfgPoor        |-100          |-100           |
      |indexRouteMapSSSRSSICnfgFair      |indexRouteMapSSSRSSICnfgFair        |-95           |-95           |
      |indexRouteMapSSSRSSICnfgGood      |indexRouteMapSSSRSSICnfgGood        |-90           |-90           |
      |indexRouteMapSSSRSSICnfgVery      |indexRouteMapSSSRSSICnfgVery        |-80           |-80           |
      |indexRouteMapSSSRSSICnfgExec      |indexRouteMapSSSRSSICnfgExec        |-70           |-70           |

      |indexRouteMapSSSRSSICnfgGood      |indexRouteMapSSSRSSICnfgVery        |-50          |-50           |
      |indexRouteMapSSSRSSICnfgGood      |indexRouteMapSSSRSSICnfgExec        |-50          |-50           |

      |indexRouteMapSSSRSSICnfgPoor      |indexRouteMapSSSRSSICnfgPoor        |-100          |-100           |
      |indexRouteMapSSSRSSICnfgFair      |indexRouteMapSSSRSSICnfgFair        |-95           |-95           |
      |indexRouteMapSSSRSSICnfgGood      |indexRouteMapSSSRSSICnfgGood        |-90           |-90           |
      |indexRouteMapSSSRSSICnfgVery      |indexRouteMapSSSRSSICnfgVery        |-80           |-80           |
      |indexRouteMapSSSRSSICnfgExec      |indexRouteMapSSSRSSICnfgExec        |-70           |-70           |

      |indexRouteMapSSSRSSICnfgVery      |indexRouteMapSSSRSSICnfgExec        |-50          |-50           |

      |indexRouteMapSSSRSSICnfgPoor      |indexRouteMapSSSRSSICnfgPoor        |-100          |-100           |
      |indexRouteMapSSSRSSICnfgFair      |indexRouteMapSSSRSSICnfgFair        |-95           |-95           |
      |indexRouteMapSSSRSSICnfgGood      |indexRouteMapSSSRSSICnfgGood        |-90           |-90           |
      |indexRouteMapSSSRSSICnfgVery      |indexRouteMapSSSRSSICnfgVery        |-80           |-80           |
      |indexRouteMapSSSRSSICnfgExec      |indexRouteMapSSSRSSICnfgExec        |-70           |-70           |

      |indexRouteMapSSSRSSICnfgExec      |indexRouteMapSSSRSSICnfgVery        |-110           |-110           |
      |indexRouteMapSSSRSSICnfgExec      |indexRouteMapSSSRSSICnfgGood        |-110           |-110           |
      |indexRouteMapSSSRSSICnfgExec      |indexRouteMapSSSRSSICnfgFair        |-110           |-110           |
      |indexRouteMapSSSRSSICnfgExec      |indexRouteMapSSSRSSICnfgPoor        |-110           |-110           |

      |indexRouteMapSSSRSSICnfgPoor      |indexRouteMapSSSRSSICnfgPoor        |-100          |-100           |
      |indexRouteMapSSSRSSICnfgFair      |indexRouteMapSSSRSSICnfgFair        |-95           |-95           |
      |indexRouteMapSSSRSSICnfgGood      |indexRouteMapSSSRSSICnfgGood        |-90           |-90           |
      |indexRouteMapSSSRSSICnfgVery      |indexRouteMapSSSRSSICnfgVery        |-80           |-80           |
      |indexRouteMapSSSRSSICnfgExec      |indexRouteMapSSSRSSICnfgExec        |-70           |-70           |

      |indexRouteMapSSSRSSICnfgVery      |indexRouteMapSSSRSSICnfgGood        |-110           |-110           |
      |indexRouteMapSSSRSSICnfgVery      |indexRouteMapSSSRSSICnfgFair        |-110           |-110           |
      |indexRouteMapSSSRSSICnfgVery      |indexRouteMapSSSRSSICnfgPoor        |-110           |-110           |

      |indexRouteMapSSSRSSICnfgPoor      |indexRouteMapSSSRSSICnfgPoor        |-100          |-100           |
      |indexRouteMapSSSRSSICnfgFair      |indexRouteMapSSSRSSICnfgFair        |-95           |-95           |
      |indexRouteMapSSSRSSICnfgGood      |indexRouteMapSSSRSSICnfgGood        |-90           |-90           |
      |indexRouteMapSSSRSSICnfgVery      |indexRouteMapSSSRSSICnfgVery        |-80           |-80           |
      |indexRouteMapSSSRSSICnfgExec      |indexRouteMapSSSRSSICnfgExec        |-70           |-70           |

      |indexRouteMapSSSRSSICnfgGood      |indexRouteMapSSSRSSICnfgFair        |-110           |-110           |
      |indexRouteMapSSSRSSICnfgGood      |indexRouteMapSSSRSSICnfgPoor        |-110           |-110           |

      |indexRouteMapSSSRSSICnfgPoor      |indexRouteMapSSSRSSICnfgPoor        |-100          |-100           |
      |indexRouteMapSSSRSSICnfgFair      |indexRouteMapSSSRSSICnfgFair        |-95           |-95           |
      |indexRouteMapSSSRSSICnfgGood      |indexRouteMapSSSRSSICnfgGood        |-90           |-90           |
      |indexRouteMapSSSRSSICnfgVery      |indexRouteMapSSSRSSICnfgVery        |-80           |-80           |
      |indexRouteMapSSSRSSICnfgExec      |indexRouteMapSSSRSSICnfgExec        |-70           |-70           |

      |indexRouteMapSSSRSSICnfgFair      |indexRouteMapSSSRSSICnfgPoor        |-110           |-110           |

#######################################################################################################################
  Scenario Outline: indexRouteMapPSSPWRCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                |targetid     |inputValue   |expectValue    |
      |indexRouteMapPSSPWRCnfgPoor      |indexRouteMapPSSPWRCnfgPoor        |-100          |-100           |
      |indexRouteMapPSSPWRCnfgFair      |indexRouteMapPSSPWRCnfgFair        |-95           |-95           |
      |indexRouteMapPSSPWRCnfgGood      |indexRouteMapPSSPWRCnfgGood        |-90           |-90           |
      |indexRouteMapPSSPWRCnfgVery      |indexRouteMapPSSPWRCnfgVery        |-80           |-80           |
      |indexRouteMapPSSPWRCnfgExec      |indexRouteMapPSSPWRCnfgExec        |-70           |-70           |

      |indexRouteMapPSSPWRCnfgPoor      |indexRouteMapPSSPWRCnfgFair        |-50          |-50           |
      |indexRouteMapPSSPWRCnfgPoor      |indexRouteMapPSSPWRCnfgGood        |-50          |-50           |
      |indexRouteMapPSSPWRCnfgPoor      |indexRouteMapPSSPWRCnfgVery        |-50          |-50           |
      |indexRouteMapPSSPWRCnfgPoor      |indexRouteMapPSSPWRCnfgExec        |-50          |-50           |

      |indexRouteMapPSSPWRCnfgPoor      |indexRouteMapPSSPWRCnfgPoor        |-100          |-100           |
      |indexRouteMapPSSPWRCnfgFair      |indexRouteMapPSSPWRCnfgFair        |-95           |-95           |
      |indexRouteMapPSSPWRCnfgGood      |indexRouteMapPSSPWRCnfgGood        |-90           |-90           |
      |indexRouteMapPSSPWRCnfgVery      |indexRouteMapPSSPWRCnfgVery        |-80           |-80           |
      |indexRouteMapPSSPWRCnfgExec      |indexRouteMapPSSPWRCnfgExec        |-70           |-70           |

      |indexRouteMapPSSPWRCnfgFair      |indexRouteMapPSSPWRCnfgGood        |-50          |-50           |
      |indexRouteMapPSSPWRCnfgFair      |indexRouteMapPSSPWRCnfgVery        |-50          |-50           |
      |indexRouteMapPSSPWRCnfgFair      |indexRouteMapPSSPWRCnfgExec        |-50          |-50           |

      |indexRouteMapPSSPWRCnfgPoor      |indexRouteMapPSSPWRCnfgPoor        |-100          |-100           |
      |indexRouteMapPSSPWRCnfgFair      |indexRouteMapPSSPWRCnfgFair        |-95           |-95           |
      |indexRouteMapPSSPWRCnfgGood      |indexRouteMapPSSPWRCnfgGood        |-90           |-90           |
      |indexRouteMapPSSPWRCnfgVery      |indexRouteMapPSSPWRCnfgVery        |-80           |-80           |
      |indexRouteMapPSSPWRCnfgExec      |indexRouteMapPSSPWRCnfgExec        |-70           |-70           |

      |indexRouteMapPSSPWRCnfgGood      |indexRouteMapPSSPWRCnfgVery        |-50          |-50           |
      |indexRouteMapPSSPWRCnfgGood      |indexRouteMapPSSPWRCnfgExec        |-50          |-50           |

      |indexRouteMapPSSPWRCnfgPoor      |indexRouteMapPSSPWRCnfgPoor        |-100          |-100           |
      |indexRouteMapPSSPWRCnfgFair      |indexRouteMapPSSPWRCnfgFair        |-95           |-95           |
      |indexRouteMapPSSPWRCnfgGood      |indexRouteMapPSSPWRCnfgGood        |-90           |-90           |
      |indexRouteMapPSSPWRCnfgVery      |indexRouteMapPSSPWRCnfgVery        |-80           |-80           |
      |indexRouteMapPSSPWRCnfgExec      |indexRouteMapPSSPWRCnfgExec        |-70           |-70           |

      |indexRouteMapPSSPWRCnfgVery      |indexRouteMapPSSPWRCnfgExec        |-50          |-50           |

      |indexRouteMapPSSPWRCnfgPoor      |indexRouteMapPSSPWRCnfgPoor        |-100          |-100           |
      |indexRouteMapPSSPWRCnfgFair      |indexRouteMapPSSPWRCnfgFair        |-95           |-95           |
      |indexRouteMapPSSPWRCnfgGood      |indexRouteMapPSSPWRCnfgGood        |-90           |-90           |
      |indexRouteMapPSSPWRCnfgVery      |indexRouteMapPSSPWRCnfgVery        |-80           |-80           |
      |indexRouteMapPSSPWRCnfgExec      |indexRouteMapPSSPWRCnfgExec        |-70           |-70           |

      |indexRouteMapPSSPWRCnfgExec      |indexRouteMapPSSPWRCnfgVery        |-110           |-110           |
      |indexRouteMapPSSPWRCnfgExec      |indexRouteMapPSSPWRCnfgGood        |-110           |-110           |
      |indexRouteMapPSSPWRCnfgExec      |indexRouteMapPSSPWRCnfgFair        |-110           |-110           |
      |indexRouteMapPSSPWRCnfgExec      |indexRouteMapPSSPWRCnfgPoor        |-110           |-110           |

      |indexRouteMapPSSPWRCnfgPoor      |indexRouteMapPSSPWRCnfgPoor        |-100          |-100           |
      |indexRouteMapPSSPWRCnfgFair      |indexRouteMapPSSPWRCnfgFair        |-95           |-95           |
      |indexRouteMapPSSPWRCnfgGood      |indexRouteMapPSSPWRCnfgGood        |-90           |-90           |
      |indexRouteMapPSSPWRCnfgVery      |indexRouteMapPSSPWRCnfgVery        |-80           |-80           |
      |indexRouteMapPSSPWRCnfgExec      |indexRouteMapPSSPWRCnfgExec        |-70           |-70           |

      |indexRouteMapPSSPWRCnfgVery      |indexRouteMapPSSPWRCnfgGood        |-110           |-110           |
      |indexRouteMapPSSPWRCnfgVery      |indexRouteMapPSSPWRCnfgFair        |-110           |-110           |
      |indexRouteMapPSSPWRCnfgVery      |indexRouteMapPSSPWRCnfgPoor        |-110           |-110           |

      |indexRouteMapPSSPWRCnfgPoor      |indexRouteMapPSSPWRCnfgPoor        |-100          |-100           |
      |indexRouteMapPSSPWRCnfgFair      |indexRouteMapPSSPWRCnfgFair        |-95           |-95           |
      |indexRouteMapPSSPWRCnfgGood      |indexRouteMapPSSPWRCnfgGood        |-90           |-90           |
      |indexRouteMapPSSPWRCnfgVery      |indexRouteMapPSSPWRCnfgVery        |-80           |-80           |
      |indexRouteMapPSSPWRCnfgExec      |indexRouteMapPSSPWRCnfgExec        |-70           |-70           |

      |indexRouteMapPSSPWRCnfgGood      |indexRouteMapPSSPWRCnfgFair        |-110           |-110           |
      |indexRouteMapPSSPWRCnfgGood      |indexRouteMapPSSPWRCnfgPoor        |-110           |-110           |

      |indexRouteMapPSSPWRCnfgPoor      |indexRouteMapPSSPWRCnfgPoor        |-100          |-100           |
      |indexRouteMapPSSPWRCnfgFair      |indexRouteMapPSSPWRCnfgFair        |-95           |-95           |
      |indexRouteMapPSSPWRCnfgGood      |indexRouteMapPSSPWRCnfgGood        |-90           |-90           |
      |indexRouteMapPSSPWRCnfgVery      |indexRouteMapPSSPWRCnfgVery        |-80           |-80           |
      |indexRouteMapPSSPWRCnfgExec      |indexRouteMapPSSPWRCnfgExec        |-70           |-70           |

      |indexRouteMapPSSPWRCnfgFair      |indexRouteMapPSSPWRCnfgPoor        |-110           |-110           |

#######################################################################################################################
  Scenario Outline: indexRouteMapSSSPWRCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                |targetid     |inputValue   |expectValue    |
      |indexRouteMapSSSPWRCnfgPoor      |indexRouteMapSSSPWRCnfgPoor        |-100          |-100           |
      |indexRouteMapSSSPWRCnfgFair      |indexRouteMapSSSPWRCnfgFair        |-95           |-95           |
      |indexRouteMapSSSPWRCnfgGood      |indexRouteMapSSSPWRCnfgGood        |-90           |-90           |
      |indexRouteMapSSSPWRCnfgVery      |indexRouteMapSSSPWRCnfgVery        |-80           |-80           |
      |indexRouteMapSSSPWRCnfgExec      |indexRouteMapSSSPWRCnfgExec        |-70           |-70           |

      |indexRouteMapSSSPWRCnfgPoor      |indexRouteMapSSSPWRCnfgFair        |-50          |-50           |
      |indexRouteMapSSSPWRCnfgPoor      |indexRouteMapSSSPWRCnfgGood        |-50          |-50           |
      |indexRouteMapSSSPWRCnfgPoor      |indexRouteMapSSSPWRCnfgVery        |-50          |-50           |
      |indexRouteMapSSSPWRCnfgPoor      |indexRouteMapSSSPWRCnfgExec        |-50          |-50           |

      |indexRouteMapSSSPWRCnfgPoor      |indexRouteMapSSSPWRCnfgPoor        |-100          |-100           |
      |indexRouteMapSSSPWRCnfgFair      |indexRouteMapSSSPWRCnfgFair        |-95           |-95           |
      |indexRouteMapSSSPWRCnfgGood      |indexRouteMapSSSPWRCnfgGood        |-90           |-90           |
      |indexRouteMapSSSPWRCnfgVery      |indexRouteMapSSSPWRCnfgVery        |-80           |-80           |
      |indexRouteMapSSSPWRCnfgExec      |indexRouteMapSSSPWRCnfgExec        |-70           |-70           |

      |indexRouteMapSSSPWRCnfgFair      |indexRouteMapSSSPWRCnfgGood        |-50          |-50           |
      |indexRouteMapSSSPWRCnfgFair      |indexRouteMapSSSPWRCnfgVery        |-50          |-50           |
      |indexRouteMapSSSPWRCnfgFair      |indexRouteMapSSSPWRCnfgExec        |-50          |-50           |

      |indexRouteMapSSSPWRCnfgPoor      |indexRouteMapSSSPWRCnfgPoor        |-100          |-100           |
      |indexRouteMapSSSPWRCnfgFair      |indexRouteMapSSSPWRCnfgFair        |-95           |-95           |
      |indexRouteMapSSSPWRCnfgGood      |indexRouteMapSSSPWRCnfgGood        |-90           |-90           |
      |indexRouteMapSSSPWRCnfgVery      |indexRouteMapSSSPWRCnfgVery        |-80           |-80           |
      |indexRouteMapSSSPWRCnfgExec      |indexRouteMapSSSPWRCnfgExec        |-70           |-70           |

      |indexRouteMapSSSPWRCnfgGood      |indexRouteMapSSSPWRCnfgVery        |-50          |-50           |
      |indexRouteMapSSSPWRCnfgGood      |indexRouteMapSSSPWRCnfgExec        |-50          |-50           |

      |indexRouteMapSSSPWRCnfgPoor      |indexRouteMapSSSPWRCnfgPoor        |-100          |-100           |
      |indexRouteMapSSSPWRCnfgFair      |indexRouteMapSSSPWRCnfgFair        |-95           |-95           |
      |indexRouteMapSSSPWRCnfgGood      |indexRouteMapSSSPWRCnfgGood        |-90           |-90           |
      |indexRouteMapSSSPWRCnfgVery      |indexRouteMapSSSPWRCnfgVery        |-80           |-80           |
      |indexRouteMapSSSPWRCnfgExec      |indexRouteMapSSSPWRCnfgExec        |-70           |-70           |

      |indexRouteMapSSSPWRCnfgVery      |indexRouteMapSSSPWRCnfgExec        |-50          |-50           |

      |indexRouteMapSSSPWRCnfgPoor      |indexRouteMapSSSPWRCnfgPoor        |-100          |-100           |
      |indexRouteMapSSSPWRCnfgFair      |indexRouteMapSSSPWRCnfgFair        |-95           |-95           |
      |indexRouteMapSSSPWRCnfgGood      |indexRouteMapSSSPWRCnfgGood        |-90           |-90           |
      |indexRouteMapSSSPWRCnfgVery      |indexRouteMapSSSPWRCnfgVery        |-80           |-80           |
      |indexRouteMapSSSPWRCnfgExec      |indexRouteMapSSSPWRCnfgExec        |-70           |-70           |

      |indexRouteMapSSSPWRCnfgExec      |indexRouteMapSSSPWRCnfgVery        |-110           |-110           |
      |indexRouteMapSSSPWRCnfgExec      |indexRouteMapSSSPWRCnfgGood        |-110           |-110           |
      |indexRouteMapSSSPWRCnfgExec      |indexRouteMapSSSPWRCnfgFair        |-110           |-110           |
      |indexRouteMapSSSPWRCnfgExec      |indexRouteMapSSSPWRCnfgPoor        |-110           |-110           |

      |indexRouteMapSSSPWRCnfgPoor      |indexRouteMapSSSPWRCnfgPoor        |-100          |-100           |
      |indexRouteMapSSSPWRCnfgFair      |indexRouteMapSSSPWRCnfgFair        |-95           |-95           |
      |indexRouteMapSSSPWRCnfgGood      |indexRouteMapSSSPWRCnfgGood        |-90           |-90           |
      |indexRouteMapSSSPWRCnfgVery      |indexRouteMapSSSPWRCnfgVery        |-80           |-80           |
      |indexRouteMapSSSPWRCnfgExec      |indexRouteMapSSSPWRCnfgExec        |-70           |-70           |

      |indexRouteMapSSSPWRCnfgVery      |indexRouteMapSSSPWRCnfgGood        |-110           |-110           |
      |indexRouteMapSSSPWRCnfgVery      |indexRouteMapSSSPWRCnfgFair        |-110           |-110           |
      |indexRouteMapSSSPWRCnfgVery      |indexRouteMapSSSPWRCnfgPoor        |-110           |-110           |

      |indexRouteMapSSSPWRCnfgPoor      |indexRouteMapSSSPWRCnfgPoor        |-100          |-100           |
      |indexRouteMapSSSPWRCnfgFair      |indexRouteMapSSSPWRCnfgFair        |-95           |-95           |
      |indexRouteMapSSSPWRCnfgGood      |indexRouteMapSSSPWRCnfgGood        |-90           |-90           |
      |indexRouteMapSSSPWRCnfgVery      |indexRouteMapSSSPWRCnfgVery        |-80           |-80           |
      |indexRouteMapSSSPWRCnfgExec      |indexRouteMapSSSPWRCnfgExec        |-70           |-70           |

      |indexRouteMapSSSPWRCnfgGood      |indexRouteMapSSSPWRCnfgFair        |-110           |-110           |
      |indexRouteMapSSSPWRCnfgGood      |indexRouteMapSSSPWRCnfgPoor        |-110           |-110           |

      |indexRouteMapSSSPWRCnfgPoor      |indexRouteMapSSSPWRCnfgPoor        |-100          |-100           |
      |indexRouteMapSSSPWRCnfgFair      |indexRouteMapSSSPWRCnfgFair        |-95           |-95           |
      |indexRouteMapSSSPWRCnfgGood      |indexRouteMapSSSPWRCnfgGood        |-90           |-90           |
      |indexRouteMapSSSPWRCnfgVery      |indexRouteMapSSSPWRCnfgVery        |-80           |-80           |
      |indexRouteMapSSSPWRCnfgExec      |indexRouteMapSSSPWRCnfgExec        |-70           |-70           |

      |indexRouteMapSSSPWRCnfgFair      |indexRouteMapSSSPWRCnfgPoor        |-110           |-110           |

#######################################################################################################################
  Scenario Outline: indexRouteMapSSSECIOCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                |targetid     |inputValue   |expectValue    |
      |indexRouteMapSSSECIOCnfgPoor      |indexRouteMapSSSECIOCnfgPoor        |-100          |-100           |
      |indexRouteMapSSSECIOCnfgFair      |indexRouteMapSSSECIOCnfgFair        |-95           |-95           |
      |indexRouteMapSSSECIOCnfgGood      |indexRouteMapSSSECIOCnfgGood        |-90           |-90           |

      |indexRouteMapSSSECIOCnfgPoor      |indexRouteMapSSSECIOCnfgFair        |-50          |-50           |
      |indexRouteMapSSSECIOCnfgPoor      |indexRouteMapSSSECIOCnfgGood        |-50          |-50           |

      |indexRouteMapSSSECIOCnfgPoor      |indexRouteMapSSSECIOCnfgPoor        |-100          |-100           |
      |indexRouteMapSSSECIOCnfgFair      |indexRouteMapSSSECIOCnfgFair        |-95           |-95           |
      |indexRouteMapSSSECIOCnfgGood      |indexRouteMapSSSECIOCnfgGood        |-90           |-90           |

      |indexRouteMapSSSECIOCnfgFair      |indexRouteMapSSSECIOCnfgGood        |-50          |-50           |

      |indexRouteMapSSSECIOCnfgPoor      |indexRouteMapSSSECIOCnfgPoor        |-100          |-100           |
      |indexRouteMapSSSECIOCnfgFair      |indexRouteMapSSSECIOCnfgFair        |-95           |-95           |
      |indexRouteMapSSSECIOCnfgGood      |indexRouteMapSSSECIOCnfgGood        |-90           |-90           |

      |indexRouteMapSSSECIOCnfgPoor      |indexRouteMapSSSECIOCnfgPoor        |-100          |-100           |
      |indexRouteMapSSSECIOCnfgFair      |indexRouteMapSSSECIOCnfgFair        |-95           |-95           |
      |indexRouteMapSSSECIOCnfgGood      |indexRouteMapSSSECIOCnfgGood        |-90           |-90           |

      |indexRouteMapSSSECIOCnfgPoor      |indexRouteMapSSSECIOCnfgPoor        |-100          |-100           |
      |indexRouteMapSSSECIOCnfgFair      |indexRouteMapSSSECIOCnfgFair        |-95           |-95           |
      |indexRouteMapSSSECIOCnfgGood      |indexRouteMapSSSECIOCnfgGood        |-90           |-90           |

      |indexRouteMapSSSECIOCnfgGood      |indexRouteMapSSSECIOCnfgFair        |-110           |-110           |
      |indexRouteMapSSSECIOCnfgGood      |indexRouteMapSSSECIOCnfgPoor        |-110           |-110           |

      |indexRouteMapSSSECIOCnfgPoor      |indexRouteMapSSSECIOCnfgPoor        |-100          |-100           |
      |indexRouteMapSSSECIOCnfgFair      |indexRouteMapSSSECIOCnfgFair        |-95           |-95           |
      |indexRouteMapSSSECIOCnfgGood      |indexRouteMapSSSECIOCnfgGood        |-90           |-90           |

      |indexRouteMapSSSECIOCnfgFair      |indexRouteMapSSSECIOCnfgPoor        |-110           |-110           |

#######################################################################################################################
  Scenario Outline: detectorTraceInfoCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                |targetid     |inputValue   |expectValue    |
      |typeTraceCnfg06      |detectorTraceInfoCnfg06        |ClearWrite          |RMS           |
      |typeTraceCnfg05      |detectorTraceInfoCnfg05        |ClearWrite          |RMS           |
      |typeTraceCnfg04      |detectorTraceInfoCnfg04        |ClearWrite          |RMS           |
      |typeTraceCnfg03      |detectorTraceInfoCnfg03        |ClearWrite          |RMS           |
      |typeTraceCnfg02      |detectorTraceInfoCnfg02        |ClearWrite          |RMS           |
      |typeTraceCnfg01      |detectorTraceInfoCnfg01        |ClearWrite          |RMS           |

#######################################################################################################################
  Scenario Outline: resolutionBandwidthTraceInfoCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                |targetid     |inputValue   |expectValue    |
      |typeTraceCnfg06      |resolutionBandwidthTraceInfoCnfg06        |ClearWrite          |0.1           |
      |typeTraceCnfg05      |resolutionBandwidthTraceInfoCnfg05        |ClearWrite          |0.1           |
      |typeTraceCnfg04      |resolutionBandwidthTraceInfoCnfg04        |ClearWrite          |0.1           |
      |typeTraceCnfg03      |resolutionBandwidthTraceInfoCnfg03        |ClearWrite          |0.1           |
      |typeTraceCnfg02      |resolutionBandwidthTraceInfoCnfg02        |ClearWrite          |0.1           |
      |typeTraceCnfg01      |resolutionBandwidthTraceInfoCnfg01        |ClearWrite          |0.1           |

#######################################################################################################################
  Scenario Outline: videoBandwidthTraceInfoCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                |targetid     |inputValue   |expectValue    |
      |typeTraceCnfg06      |videoBandwidthTraceInfoCnfg06        |ClearWrite          |0.1           |
      |typeTraceCnfg05      |videoBandwidthTraceInfoCnfg05        |ClearWrite          |0.1           |
      |typeTraceCnfg04      |videoBandwidthTraceInfoCnfg04        |ClearWrite          |0.1           |
      |typeTraceCnfg03      |videoBandwidthTraceInfoCnfg03        |ClearWrite          |0.1           |
      |typeTraceCnfg02      |videoBandwidthTraceInfoCnfg02        |ClearWrite          |0.1           |
      |typeTraceCnfg01      |videoBandwidthTraceInfoCnfg01        |ClearWrite          |0.1           |

#######################################################################################################################
  Scenario Outline: averageTraceInfoCnfg01 test
    When I change <id> value to <inputValue>.
    Then I make sure that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                |targetid     |inputValue   |expectValue    |
      |averageCnfg          |averageCnfg                    |10         |10          |
      |typeTraceCnfg06      |averageTraceInfoCnfg06        |ClearWrite          |10           |
      |typeTraceCnfg05      |averageTraceInfoCnfg05        |ClearWrite          |10           |
      |typeTraceCnfg04      |averageTraceInfoCnfg04        |ClearWrite          |10           |
      |typeTraceCnfg03      |averageTraceInfoCnfg03        |ClearWrite          |10           |
      |typeTraceCnfg02      |averageTraceInfoCnfg02        |ClearWrite          |10           |
      |typeTraceCnfg01      |averageTraceInfoCnfg01        |ClearWrite          |10           |
      |averageCnfg          |averageCnfg                    |1         |1          |

#######################################################################################################################
  Scenario Outline: firstPreampTraceInfoCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                |targetid     |inputValue   |expectValue    |
      |firstAmpCnfg          |firstAmpCnfg                    |On         |On          |
      |typeTraceCnfg06      |firstPreampTraceInfoCnfg06        |ClearWrite          |On           |
      |typeTraceCnfg05      |firstPreampTraceInfoCnfg05        |ClearWrite          |On           |
      |typeTraceCnfg04      |firstPreampTraceInfoCnfg04        |ClearWrite          |On           |
      |typeTraceCnfg03      |firstPreampTraceInfoCnfg03        |ClearWrite          |On           |
      |typeTraceCnfg02      |firstPreampTraceInfoCnfg02        |ClearWrite          |On           |
      |typeTraceCnfg01      |firstPreampTraceInfoCnfg01        |ClearWrite          |On           |
      |firstAmpCnfg          |firstAmpCnfg                    |Off         |Off          |
      |typeTraceCnfg06      |firstPreampTraceInfoCnfg06        |ClearWrite          |Off           |
      |typeTraceCnfg05      |firstPreampTraceInfoCnfg05        |ClearWrite          |Off           |
      |typeTraceCnfg04      |firstPreampTraceInfoCnfg04        |ClearWrite          |Off           |
      |typeTraceCnfg03      |firstPreampTraceInfoCnfg03        |ClearWrite          |Off           |
      |typeTraceCnfg02      |firstPreampTraceInfoCnfg02        |ClearWrite          |Off           |
      |typeTraceCnfg01      |firstPreampTraceInfoCnfg01        |ClearWrite          |Off           |

#######################################################################################################################
  Scenario Outline: attenuationTraceInfoCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                |targetid     |inputValue   |expectValue    |
      |attenuationValueCnfg          |attenuationValueCnfg                    |30         |30          |
      |typeTraceCnfg06      |attenuationTraceInfoCnfg06        |ClearWrite          |30           |
      |typeTraceCnfg05      |attenuationTraceInfoCnfg05        |ClearWrite          |30           |
      |typeTraceCnfg04      |attenuationTraceInfoCnfg04        |ClearWrite          |30           |
      |typeTraceCnfg03      |attenuationTraceInfoCnfg03        |ClearWrite          |30           |
      |typeTraceCnfg02      |attenuationTraceInfoCnfg02        |ClearWrite          |30           |
      |typeTraceCnfg01      |attenuationTraceInfoCnfg01        |ClearWrite          |30           |
      |attenuationValueCnfg          |attenuationValueCnfg                    |5         |5          |
      |typeTraceCnfg06      |attenuationTraceInfoCnfg06        |ClearWrite          |5           |
      |typeTraceCnfg05      |attenuationTraceInfoCnfg05        |ClearWrite          |5           |
      |typeTraceCnfg04      |attenuationTraceInfoCnfg04        |ClearWrite          |5           |
      |typeTraceCnfg03      |attenuationTraceInfoCnfg03        |ClearWrite          |5           |
      |typeTraceCnfg02      |attenuationTraceInfoCnfg02        |ClearWrite          |5           |
      |typeTraceCnfg01      |attenuationTraceInfoCnfg01        |ClearWrite          |5           |

#######################################################################################################################
  Scenario Outline: externalOffsetTraceInfoCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                |targetid     |inputValue   |expectValue    |
      |externalOffsetCnfg          |externalOffsetCnfg                    |30         |30          |
      |typeTraceCnfg06      |externalOffsetTraceInfoCnfg06        |ClearWrite          |30           |
      |typeTraceCnfg05      |externalOffsetTraceInfoCnfg05        |ClearWrite          |30           |
      |typeTraceCnfg04      |externalOffsetTraceInfoCnfg04        |ClearWrite          |30           |
      |typeTraceCnfg03      |externalOffsetTraceInfoCnfg03        |ClearWrite          |30           |
      |typeTraceCnfg02      |externalOffsetTraceInfoCnfg02        |ClearWrite          |30           |
      |typeTraceCnfg01      |externalOffsetTraceInfoCnfg01        |ClearWrite          |30           |
      |externalOffsetCnfg          |externalOffsetCnfg                    |5         |5          |
      |typeTraceCnfg06      |externalOffsetTraceInfoCnfg06        |ClearWrite          |5           |
      |typeTraceCnfg05      |externalOffsetTraceInfoCnfg05        |ClearWrite          |5           |
      |typeTraceCnfg04      |externalOffsetTraceInfoCnfg04        |ClearWrite          |5           |
      |typeTraceCnfg03      |externalOffsetTraceInfoCnfg03        |ClearWrite          |5           |
      |typeTraceCnfg02      |externalOffsetTraceInfoCnfg02        |ClearWrite          |5           |
      |typeTraceCnfg01      |externalOffsetTraceInfoCnfg01        |ClearWrite          |5           |
#######################################################################################################################
  Scenario Outline: modeLimitChanPwrCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeLimitChanPwrCnfg              |On           |On           |
      |modeLimitChanPwrCnfg              |Off           |Off           |
      |modeLimitChanPwrCnfg              |On           |On           |
      |modeLimitChanPwrCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modeLimitOccBWCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeLimitOccBWCnfg              |On           |On           |
      |modeLimitOccBWCnfg              |Off           |Off           |
      |modeLimitOccBWCnfg              |On           |On           |
      |modeLimitOccBWCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modeLimitSEMCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeLimitSEMCnfg              |On           |On           |
      |modeLimitSEMCnfg              |Off           |Off           |
      |modeLimitSEMCnfg              |On           |On           |
      |modeLimitSEMCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modeLimitACPCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeLimitACPCnfg              |On           |On           |
      |modeLimitACPCnfg              |Off           |Off           |
      |modeLimitACPCnfg              |On           |On           |
      |modeLimitACPCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: aaaaa test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeLimitMACPCnfg              |On           |On           |
      |modeLimitMACPCnfg              |Off           |Off           |
      |modeLimitMACPCnfg              |On           |On           |
      |modeLimitMACPCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modeLimitSpurCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeLimitSpurCnfg              |On           |On           |
      |modeLimitSpurCnfg              |Off           |Off           |
      |modeLimitSpurCnfg              |On           |On           |
      |modeLimitSpurCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modeLimitFreqErrCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeLimitFreqErrCnfg              |On           |On           |
      |modeLimitFreqErrCnfg              |Off           |Off           |
      |modeLimitFreqErrCnfg              |On           |On           |
      |modeLimitFreqErrCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modeLimitSlotAveragePowerCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeLimitSlotAveragePowerCnfg              |On           |On           |
      |modeLimitSlotAveragePowerCnfg              |Off           |Off           |
      |modeLimitSlotAveragePowerCnfg              |On           |On           |
      |modeLimitSlotAveragePowerCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modeLimitOffPowerCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeLimitOffPowerCnfg              |On           |On           |
      |modeLimitOffPowerCnfg              |Off           |Off           |
      |modeLimitOffPowerCnfg              |On           |On           |
      |modeLimitOffPowerCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modeLimitTrnasitionPeriodCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeLimitTrnasitionPeriodCnfg              |On           |On           |
      |modeLimitTrnasitionPeriodCnfg              |Off           |Off           |
      |modeLimitTrnasitionPeriodCnfg              |On           |On           |
      |modeLimitTrnasitionPeriodCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modeLimitEVMPDSCHCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeLimitEVMPDSCHCnfg              |On           |On           |
      |modeLimitEVMPDSCHCnfg              |Off           |Off           |
      |modeLimitEVMPDSCHCnfg              |On           |On           |
      |modeLimitEVMPDSCHCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modeLimitEVMDataRMSCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeLimitEVMDataRMSCnfg              |On           |On           |
      |modeLimitEVMDataRMSCnfg              |Off           |Off           |
      |modeLimitEVMDataRMSCnfg              |On           |On           |
      |modeLimitEVMDataRMSCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modeLimitEVMDataPeakCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeLimitEVMDataPeakCnfg              |On           |On           |
      |modeLimitEVMDataPeakCnfg              |Off           |Off           |
      |modeLimitEVMDataPeakCnfg              |On           |On           |
      |modeLimitEVMDataPeakCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modeLimitEVMRSCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeLimitEVMRSCnfg              |On           |On           |
      |modeLimitEVMRSCnfg              |Off           |Off           |
      |modeLimitEVMRSCnfg              |On           |On           |
      |modeLimitEVMRSCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modeLimitEVMPSSCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeLimitEVMPSSCnfg              |On           |On           |
      |modeLimitEVMPSSCnfg              |Off           |Off           |
      |modeLimitEVMPSSCnfg              |On           |On           |
      |modeLimitEVMPSSCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modeLimitEVMSSSCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeLimitEVMSSSCnfg              |On           |On           |
      |modeLimitEVMSSSCnfg              |Off           |Off           |
      |modeLimitEVMSSSCnfg              |On           |On           |
      |modeLimitEVMSSSCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modeLimitEVMPMCHCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeLimitEVMPMCHCnfg              |On           |On           |
      |modeLimitEVMPMCHCnfg              |Off           |Off           |
      |modeLimitEVMPMCHCnfg              |On           |On           |
      |modeLimitEVMPMCHCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modeLimitPwrDLRSCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeLimitPwrDLRSCnfg              |On           |On           |
      |modeLimitPwrDLRSCnfg              |Off           |Off           |
      |modeLimitPwrDLRSCnfg              |On           |On           |
      |modeLimitPwrDLRSCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modeLimitPwrPSSCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeLimitPwrPSSCnfg              |On           |On           |
      |modeLimitPwrPSSCnfg              |Off           |Off           |
      |modeLimitPwrPSSCnfg              |On           |On           |
      |modeLimitPwrPSSCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modeLimitPwrSSSCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeLimitPwrSSSCnfg              |On           |On           |
      |modeLimitPwrSSSCnfg              |Off           |Off           |
      |modeLimitPwrSSSCnfg              |On           |On           |
      |modeLimitPwrSSSCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modeLimitPwrPBCHCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeLimitPwrPBCHCnfg              |On           |On           |
      |modeLimitPwrPBCHCnfg              |Off           |Off           |
      |modeLimitPwrPBCHCnfg              |On           |On           |
      |modeLimitPwrPBCHCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modeLimitPwrSubframeCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeLimitPwrSubframeCnfg              |On           |On           |
      |modeLimitPwrSubframeCnfg              |Off           |Off           |
      |modeLimitPwrSubframeCnfg              |On           |On           |
      |modeLimitPwrSubframeCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modeLimitPwrOFDMCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeLimitPwrOFDMCnfg              |On           |On           |
      |modeLimitPwrOFDMCnfg              |Off           |Off           |
      |modeLimitPwrOFDMCnfg              |On           |On           |
      |modeLimitPwrOFDMCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modeLimitPwrFrameAVGCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeLimitPwrFrameAVGCnfg              |On           |On           |
      |modeLimitPwrFrameAVGCnfg              |Off           |Off           |
      |modeLimitPwrFrameAVGCnfg              |On           |On           |
      |modeLimitPwrFrameAVGCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modeLimitTAEMIMOCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeLimitTAEMIMOCnfg              |On           |On           |
      |modeLimitTAEMIMOCnfg              |Off           |Off           |
      |modeLimitTAEMIMOCnfg              |On           |On           |
      |modeLimitTAEMIMOCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modeLimitTAECACnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeLimitTAECACnfg              |On           |On           |
      |modeLimitTAECACnfg              |Off           |Off           |
      |modeLimitTAECACnfg              |On           |On           |
      |modeLimitTAECACnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modeLimitTimeErrCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeLimitTimeErrCnfg              |On           |On           |
      |modeLimitTimeErrCnfg              |Off           |Off           |
      |modeLimitTimeErrCnfg              |On           |On           |
      |modeLimitTimeErrCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: modeLimitIQOriOffsetCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure that <id> value is equal to <expectValue>.

    Examples:
      |id                                 |inputValue   |expectValue    |
      |modeLimitIQOriOffsetCnfg              |On           |On           |
      |modeLimitIQOriOffsetCnfg              |Off           |Off           |
      |modeLimitIQOriOffsetCnfg              |On           |On           |
      |modeLimitIQOriOffsetCnfg              |asd           |On           |

#######################################################################################################################
  Scenario Outline: highLimitChanPwrCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitChanPwrCnfg             |highLimitChanPwrCnfg    |-120.1           |-120           |
      |highLimitChanPwrCnfg             |highLimitChanPwrCnfg    |-120           |-120           |
      |highLimitChanPwrCnfg             |highLimitChanPwrCnfg    |-119.9           |-119.9           |
      |highLimitChanPwrCnfg             |highLimitChanPwrCnfg    |99.99           |99.99           |
      |highLimitChanPwrCnfg             |highLimitChanPwrCnfg    |100             |100           |
      |highLimitChanPwrCnfg             |highLimitChanPwrCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: lowLimitChanPwrCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |lowLimitChanPwrCnfg             |lowLimitChanPwrCnfg    |-120.1           |-120           |
      |lowLimitChanPwrCnfg             |lowLimitChanPwrCnfg    |-120           |-120           |
      |lowLimitChanPwrCnfg             |lowLimitChanPwrCnfg    |-119.9           |-119.9           |
      |lowLimitChanPwrCnfg             |lowLimitChanPwrCnfg    |99.99           |99.99           |
      |lowLimitChanPwrCnfg             |lowLimitChanPwrCnfg    |100             |100           |
      |lowLimitChanPwrCnfg             |lowLimitChanPwrCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: highLimitChanPwrCnfg lowLimitChanPwrCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitChanPwrCnfg             |highLimitChanPwrCnfg    |45           |45           |
      |lowLimitChanPwrCnfg             |lowLimitChanPwrCnfg    |42           |42           |
      |highLimitChanPwrCnfg             |lowLimitChanPwrCnfg    |-120           |-120           |

      |highLimitChanPwrCnfg             |highLimitChanPwrCnfg    |45           |45           |
      |lowLimitChanPwrCnfg             |lowLimitChanPwrCnfg    |42           |42           |
      |lowLimitChanPwrCnfg             |highLimitChanPwrCnfg    |110           |100           |

#######################################################################################################################
  Scenario Outline: highLimitOccBWCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitOccBWCnfg             |highLimitOccBWCnfg    |-1           |0.001           |
      |highLimitOccBWCnfg             |highLimitOccBWCnfg    |0           |0.001           |
      |highLimitOccBWCnfg             |highLimitOccBWCnfg    |0.001           |0.001           |
      |highLimitOccBWCnfg             |highLimitOccBWCnfg    |0.002           |0.002           |
      |highLimitOccBWCnfg             |highLimitOccBWCnfg    |99.99           |99.99           |
      |highLimitOccBWCnfg             |highLimitOccBWCnfg    |100           |100           |
      |highLimitOccBWCnfg             |highLimitOccBWCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: highLimitFreqErrCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitFreqErrCnfg             |highLimitFreqErrCnfg    |-1.001           |-1           |
      |highLimitFreqErrCnfg             |highLimitFreqErrCnfg    |-1           |-1           |
      |highLimitFreqErrCnfg             |highLimitFreqErrCnfg    |-0.999           |-0.999           |
      |highLimitFreqErrCnfg             |highLimitFreqErrCnfg    |0.999           |0.999           |
      |highLimitFreqErrCnfg             |highLimitFreqErrCnfg    |1           |1           |
      |highLimitFreqErrCnfg             |highLimitFreqErrCnfg    |1.001           |1           |

#######################################################################################################################
  Scenario Outline: lowLimitFreqErrCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |lowLimitFreqErrCnfg             |lowLimitFreqErrCnfg    |-1.001           |-1           |
      |lowLimitFreqErrCnfg             |lowLimitFreqErrCnfg    |-1           |-1           |
      |lowLimitFreqErrCnfg             |lowLimitFreqErrCnfg    |-0.999           |-0.999           |
      |lowLimitFreqErrCnfg             |lowLimitFreqErrCnfg    |0.999           |0.999           |
      |lowLimitFreqErrCnfg             |lowLimitFreqErrCnfg    |1           |1           |
      |lowLimitFreqErrCnfg             |lowLimitFreqErrCnfg    |1.001           |1           |

#######################################################################################################################
  Scenario Outline: highLimitFreqErrCnfg lowLimitFreqErrCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitFreqErrCnfg             |highLimitFreqErrCnfg    |0.05           |0.05           |
      |lowLimitFreqErrCnfg             |lowLimitFreqErrCnfg    |-0.05           |-0.05           |
      |highLimitFreqErrCnfg             |lowLimitFreqErrCnfg    |-0.5          |-0.5           |
      |lowLimitFreqErrCnfg             |highLimitFreqErrCnfg    |0.5           |0.5           |
      |highLimitFreqErrCnfg             |highLimitFreqErrCnfg    |0.05           |0.05           |
      |lowLimitFreqErrCnfg             |lowLimitFreqErrCnfg    |-0.05           |-0.05           |

#######################################################################################################################
  Scenario Outline: highLimitSlotAveragePowerCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitSlotAveragePowerCnfg             |highLimitSlotAveragePowerCnfg    |-120.1           |-120           |
      |highLimitSlotAveragePowerCnfg             |highLimitSlotAveragePowerCnfg    |-120           |-120           |
      |highLimitSlotAveragePowerCnfg             |highLimitSlotAveragePowerCnfg    |-119.9           |-119.9           |
      |highLimitSlotAveragePowerCnfg             |highLimitSlotAveragePowerCnfg    |99.99           |99.99           |
      |highLimitSlotAveragePowerCnfg             |highLimitSlotAveragePowerCnfg    |100             |100           |
      |highLimitSlotAveragePowerCnfg             |highLimitSlotAveragePowerCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: lowLimitSlotAveragePowerCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |lowLimitSlotAveragePowerCnfg             |lowLimitSlotAveragePowerCnfg    |-120.1           |-120           |
      |lowLimitSlotAveragePowerCnfg             |lowLimitSlotAveragePowerCnfg    |-120           |-120           |
      |lowLimitSlotAveragePowerCnfg             |lowLimitSlotAveragePowerCnfg    |-119.9           |-119.9           |
      |lowLimitSlotAveragePowerCnfg             |lowLimitSlotAveragePowerCnfg    |99.99           |99.99           |
      |lowLimitSlotAveragePowerCnfg             |lowLimitSlotAveragePowerCnfg    |100             |100           |
      |lowLimitSlotAveragePowerCnfg             |lowLimitSlotAveragePowerCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: highLimitSlotAveragePowerCnfg lowLimitSlotAveragePowerCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitSlotAveragePowerCnfg             |highLimitSlotAveragePowerCnfg    |45           |45           |
      |lowLimitSlotAveragePowerCnfg             |lowLimitSlotAveragePowerCnfg    |42           |42           |
      |highLimitSlotAveragePowerCnfg             |lowLimitSlotAveragePowerCnfg    |10           |10           |
      |lowLimitSlotAveragePowerCnfg             |highLimitSlotAveragePowerCnfg    |20           |20           |
      |highLimitSlotAveragePowerCnfg             |highLimitSlotAveragePowerCnfg    |45           |45           |
      |lowLimitSlotAveragePowerCnfg             |lowLimitSlotAveragePowerCnfg    |42           |42           |

#######################################################################################################################
  Scenario Outline: highLimitOffPowerCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitTransitionPeriodCnfg             |highLimitTransitionPeriodCnfg    |-10001           |-10000           |
      |highLimitTransitionPeriodCnfg             |highLimitTransitionPeriodCnfg    |-10000           |-10000           |
      |highLimitTransitionPeriodCnfg             |highLimitTransitionPeriodCnfg    |-9999           |-9999           |
      |highLimitTransitionPeriodCnfg             |highLimitTransitionPeriodCnfg    |9999           |9999           |
      |highLimitTransitionPeriodCnfg             |highLimitTransitionPeriodCnfg    |10000             |10000           |
      |highLimitTransitionPeriodCnfg             |highLimitTransitionPeriodCnfg    |10001           |10000           |

#######################################################################################################################
  Scenario Outline: highLimitEVMPDSCHQPSKCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitEVMPDSCHQPSKCnfg             |highLimitEVMPDSCHQPSKCnfg    |-0.1           |0           |
      |highLimitEVMPDSCHQPSKCnfg             |highLimitEVMPDSCHQPSKCnfg    |0           |0           |
      |highLimitEVMPDSCHQPSKCnfg             |highLimitEVMPDSCHQPSKCnfg    |0.01           |0.01           |
      |highLimitEVMPDSCHQPSKCnfg             |highLimitEVMPDSCHQPSKCnfg    |99.99           |99.99           |
      |highLimitEVMPDSCHQPSKCnfg             |highLimitEVMPDSCHQPSKCnfg    |100             |100           |
      |highLimitEVMPDSCHQPSKCnfg             |highLimitEVMPDSCHQPSKCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: highLimitEVMPDSCH16QAMCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitEVMPDSCH16QAMCnfg             |highLimitEVMPDSCH16QAMCnfg    |-0.1           |0           |
      |highLimitEVMPDSCH16QAMCnfg             |highLimitEVMPDSCH16QAMCnfg    |0           |0           |
      |highLimitEVMPDSCH16QAMCnfg             |highLimitEVMPDSCH16QAMCnfg    |0.01           |0.01           |
      |highLimitEVMPDSCH16QAMCnfg             |highLimitEVMPDSCH16QAMCnfg    |99.99           |99.99           |
      |highLimitEVMPDSCH16QAMCnfg             |highLimitEVMPDSCH16QAMCnfg    |100             |100           |
      |highLimitEVMPDSCH16QAMCnfg             |highLimitEVMPDSCH16QAMCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: highLimitEVMPDSCH64QAMCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitEVMPDSCH64QAMCnfg             |highLimitEVMPDSCH64QAMCnfg    |-0.1           |0           |
      |highLimitEVMPDSCH64QAMCnfg             |highLimitEVMPDSCH64QAMCnfg    |0           |0           |
      |highLimitEVMPDSCH64QAMCnfg             |highLimitEVMPDSCH64QAMCnfg    |0.01           |0.01           |
      |highLimitEVMPDSCH64QAMCnfg             |highLimitEVMPDSCH64QAMCnfg    |99.99           |99.99           |
      |highLimitEVMPDSCH64QAMCnfg             |highLimitEVMPDSCH64QAMCnfg    |100             |100           |
      |highLimitEVMPDSCH64QAMCnfg             |highLimitEVMPDSCH64QAMCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: highLimitEVMPDSCH256QAMCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitEVMPDSCH256QAMCnfg             |highLimitEVMPDSCH256QAMCnfg    |-0.1           |0           |
      |highLimitEVMPDSCH256QAMCnfg             |highLimitEVMPDSCH256QAMCnfg    |0           |0           |
      |highLimitEVMPDSCH256QAMCnfg             |highLimitEVMPDSCH256QAMCnfg    |0.01           |0.01           |
      |highLimitEVMPDSCH256QAMCnfg             |highLimitEVMPDSCH256QAMCnfg    |99.99           |99.99           |
      |highLimitEVMPDSCH256QAMCnfg             |highLimitEVMPDSCH256QAMCnfg    |100             |100           |
      |highLimitEVMPDSCH256QAMCnfg             |highLimitEVMPDSCH256QAMCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: highLimitEVMDataRMSCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitEVMDataRMSCnfg             |highLimitEVMDataRMSCnfg    |-0.1           |0           |
      |highLimitEVMDataRMSCnfg             |highLimitEVMDataRMSCnfg    |0           |0           |
      |highLimitEVMDataRMSCnfg             |highLimitEVMDataRMSCnfg    |0.01           |0.01           |
      |highLimitEVMDataRMSCnfg             |highLimitEVMDataRMSCnfg    |99.99           |99.99           |
      |highLimitEVMDataRMSCnfg             |highLimitEVMDataRMSCnfg    |100             |100           |
      |highLimitEVMDataRMSCnfg             |highLimitEVMDataRMSCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: highLimitEVMDataPeakCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitEVMDataPeakCnfg             |highLimitEVMDataPeakCnfg    |-0.1           |0           |
      |highLimitEVMDataPeakCnfg             |highLimitEVMDataPeakCnfg    |0           |0           |
      |highLimitEVMDataPeakCnfg             |highLimitEVMDataPeakCnfg    |0.01           |0.01           |
      |highLimitEVMDataPeakCnfg             |highLimitEVMDataPeakCnfg    |99.99           |99.99           |
      |highLimitEVMDataPeakCnfg             |highLimitEVMDataPeakCnfg    |100             |100           |
      |highLimitEVMDataPeakCnfg             |highLimitEVMDataPeakCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: highLimitEVMRSCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitEVMRSCnfg             |highLimitEVMRSCnfg    |-0.1           |0           |
      |highLimitEVMRSCnfg             |highLimitEVMRSCnfg    |0           |0           |
      |highLimitEVMRSCnfg             |highLimitEVMRSCnfg    |0.01           |0.01           |
      |highLimitEVMRSCnfg             |highLimitEVMRSCnfg    |99.99           |99.99           |
      |highLimitEVMRSCnfg             |highLimitEVMRSCnfg    |100             |100           |
      |highLimitEVMRSCnfg             |highLimitEVMRSCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: highLimitEVMPSSCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitEVMPSSCnfg             |highLimitEVMPSSCnfg    |-0.1           |0           |
      |highLimitEVMPSSCnfg             |highLimitEVMPSSCnfg    |0           |0           |
      |highLimitEVMPSSCnfg             |highLimitEVMPSSCnfg    |0.01           |0.01           |
      |highLimitEVMPSSCnfg             |highLimitEVMPSSCnfg    |99.99           |99.99           |
      |highLimitEVMPSSCnfg             |highLimitEVMPSSCnfg    |100             |100           |
      |highLimitEVMPSSCnfg             |highLimitEVMPSSCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: highLimitEVMSSSCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitEVMSSSCnfg             |highLimitEVMSSSCnfg    |-0.1           |0           |
      |highLimitEVMSSSCnfg             |highLimitEVMSSSCnfg    |0           |0           |
      |highLimitEVMSSSCnfg             |highLimitEVMSSSCnfg    |0.01           |0.01           |
      |highLimitEVMSSSCnfg             |highLimitEVMSSSCnfg    |99.99           |99.99           |
      |highLimitEVMSSSCnfg             |highLimitEVMSSSCnfg    |100             |100           |
      |highLimitEVMSSSCnfg             |highLimitEVMSSSCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: highLimitEVMPMCHQPSKCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitEVMPMCHQPSKCnfg             |highLimitEVMPMCHQPSKCnfg    |-0.1           |0           |
      |highLimitEVMPMCHQPSKCnfg             |highLimitEVMPMCHQPSKCnfg    |0           |0           |
      |highLimitEVMPMCHQPSKCnfg             |highLimitEVMPMCHQPSKCnfg    |0.01           |0.01           |
      |highLimitEVMPMCHQPSKCnfg             |highLimitEVMPMCHQPSKCnfg    |99.99           |99.99           |
      |highLimitEVMPMCHQPSKCnfg             |highLimitEVMPMCHQPSKCnfg    |100             |100           |
      |highLimitEVMPMCHQPSKCnfg             |highLimitEVMPMCHQPSKCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: highLimitEVMPMCH16QAMCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitEVMPMCH16QAMCnfg             |highLimitEVMPMCH16QAMCnfg    |-0.1           |0           |
      |highLimitEVMPMCH16QAMCnfg             |highLimitEVMPMCH16QAMCnfg    |0           |0           |
      |highLimitEVMPMCH16QAMCnfg             |highLimitEVMPMCH16QAMCnfg    |0.01           |0.01           |
      |highLimitEVMPMCH16QAMCnfg             |highLimitEVMPMCH16QAMCnfg    |99.99           |99.99           |
      |highLimitEVMPMCH16QAMCnfg             |highLimitEVMPMCH16QAMCnfg    |100             |100           |
      |highLimitEVMPMCH16QAMCnfg             |highLimitEVMPMCH16QAMCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: highLimitEVMPMCH64QAMCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitEVMPMCH64QAMCnfg             |highLimitEVMPMCH64QAMCnfg    |-0.1           |0           |
      |highLimitEVMPMCH64QAMCnfg             |highLimitEVMPMCH64QAMCnfg    |0           |0           |
      |highLimitEVMPMCH64QAMCnfg             |highLimitEVMPMCH64QAMCnfg    |0.01           |0.01           |
      |highLimitEVMPMCH64QAMCnfg             |highLimitEVMPMCH64QAMCnfg    |99.99           |99.99           |
      |highLimitEVMPMCH64QAMCnfg             |highLimitEVMPMCH64QAMCnfg    |100             |100           |
      |highLimitEVMPMCH64QAMCnfg             |highLimitEVMPMCH64QAMCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: highLimitPwrDLRSCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitPwrDLRSCnfg             |highLimitPwrDLRSCnfg    |-120.1           |-120           |
      |highLimitPwrDLRSCnfg             |highLimitPwrDLRSCnfg    |-120           |-120           |
      |highLimitPwrDLRSCnfg             |highLimitPwrDLRSCnfg    |-119.99           |-119.99           |
      |highLimitPwrDLRSCnfg             |highLimitPwrDLRSCnfg    |99.99           |99.99           |
      |highLimitPwrDLRSCnfg             |highLimitPwrDLRSCnfg    |100             |100           |
      |highLimitPwrDLRSCnfg             |highLimitPwrDLRSCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: lowLimitPwrDLRSCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |lowLimitPwrDLRSCnfg             |lowLimitPwrDLRSCnfg    |-120.1           |-120           |
      |lowLimitPwrDLRSCnfg             |lowLimitPwrDLRSCnfg    |-120           |-120           |
      |lowLimitPwrDLRSCnfg             |lowLimitPwrDLRSCnfg    |-119.99           |-119.99           |
      |lowLimitPwrDLRSCnfg             |lowLimitPwrDLRSCnfg    |99.99           |99.99           |
      |lowLimitPwrDLRSCnfg             |lowLimitPwrDLRSCnfg    |100             |100           |
      |lowLimitPwrDLRSCnfg             |lowLimitPwrDLRSCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: highLimitPwrDLRSCnfg lowLimitPwrDLRSCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitPwrDLRSCnfg             |highLimitPwrDLRSCnfg    |18           |18           |
      |lowLimitPwrDLRSCnfg             |lowLimitPwrDLRSCnfg    |13           |13           |
      |highLimitPwrDLRSCnfg             |lowLimitPwrDLRSCnfg    |8           |8           |
      |lowLimitPwrDLRSCnfg             |highLimitPwrDLRSCnfg    |22           |22           |
      |highLimitPwrDLRSCnfg             |highLimitPwrDLRSCnfg    |18           |18           |
      |lowLimitPwrDLRSCnfg             |lowLimitPwrDLRSCnfg    |13           |13           |

#######################################################################################################################
  Scenario Outline: highLimitPwrPSSAbsCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitPwrPSSAbsCnfg             |highLimitPwrPSSAbsCnfg    |-120.1           |-120           |
      |highLimitPwrPSSAbsCnfg             |highLimitPwrPSSAbsCnfg    |-120           |-120           |
      |highLimitPwrPSSAbsCnfg             |highLimitPwrPSSAbsCnfg    |-119.99           |-119.99           |
      |highLimitPwrPSSAbsCnfg             |highLimitPwrPSSAbsCnfg    |99.99           |99.99           |
      |highLimitPwrPSSAbsCnfg             |highLimitPwrPSSAbsCnfg    |100             |100           |
      |highLimitPwrPSSAbsCnfg             |highLimitPwrPSSAbsCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: lowLimitPwrPSSAbsCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |lowLimitPwrPSSAbsCnfg             |lowLimitPwrPSSAbsCnfg    |-120.1           |-120           |
      |lowLimitPwrPSSAbsCnfg             |lowLimitPwrPSSAbsCnfg    |-120           |-120           |
      |lowLimitPwrPSSAbsCnfg             |lowLimitPwrPSSAbsCnfg    |-119.99           |-119.99           |
      |lowLimitPwrPSSAbsCnfg             |lowLimitPwrPSSAbsCnfg    |99.99           |99.99           |
      |lowLimitPwrPSSAbsCnfg             |lowLimitPwrPSSAbsCnfg    |100             |100           |
      |lowLimitPwrPSSAbsCnfg             |lowLimitPwrPSSAbsCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: highLimitPwrPSSAbsCnfg lowLimitPwrPSSAbsCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitPwrPSSAbsCnfg             |highLimitPwrPSSAbsCnfg    |22           |22           |
      |lowLimitPwrPSSAbsCnfg             |lowLimitPwrPSSAbsCnfg    |18           |18           |
      |highLimitPwrPSSAbsCnfg             |lowLimitPwrPSSAbsCnfg    |14           |14           |
      |lowLimitPwrPSSAbsCnfg             |highLimitPwrPSSAbsCnfg    |28           |28           |
      |highLimitPwrPSSAbsCnfg             |highLimitPwrPSSAbsCnfg    |22           |22           |
      |lowLimitPwrPSSAbsCnfg             |lowLimitPwrPSSAbsCnfg    |18           |18           |

#######################################################################################################################
  Scenario Outline: highLimitPwrPSSRelCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitPwrPSSRelCnfg             |highLimitPwrPSSRelCnfg    |-150.1           |-150           |
      |highLimitPwrPSSRelCnfg             |highLimitPwrPSSRelCnfg    |-150           |-150           |
      |highLimitPwrPSSRelCnfg             |highLimitPwrPSSRelCnfg    |-99.99           |-99.99           |
      |highLimitPwrPSSRelCnfg             |highLimitPwrPSSRelCnfg    |-0.01           |-0.01           |
      |highLimitPwrPSSRelCnfg             |highLimitPwrPSSRelCnfg    |0             |0           |
      |highLimitPwrPSSRelCnfg             |highLimitPwrPSSRelCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: lowLimitPwrPSSRelCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |lowLimitPwrPSSRelCnfg             |lowLimitPwrPSSRelCnfg    |-150.1           |-150           |
      |lowLimitPwrPSSRelCnfg             |lowLimitPwrPSSRelCnfg    |-150           |-150           |
      |lowLimitPwrPSSRelCnfg             |lowLimitPwrPSSRelCnfg    |-99.99           |-99.99           |
      |lowLimitPwrPSSRelCnfg             |lowLimitPwrPSSRelCnfg    |-0.01           |-0.01           |
      |lowLimitPwrPSSRelCnfg             |lowLimitPwrPSSRelCnfg    |0             |0           |
      |lowLimitPwrPSSRelCnfg             |lowLimitPwrPSSRelCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: highLimitPwrPSSRelCnfg lowLimitPwrPSSRelCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitPwrPSSRelCnfg             |highLimitPwrPSSRelCnfg    |-10           |-10           |
      |lowLimitPwrPSSRelCnfg             |lowLimitPwrPSSRelCnfg    |-15           |-15           |
      |highLimitPwrPSSRelCnfg             |lowLimitPwrPSSRelCnfg    |-24           |-24           |
      |lowLimitPwrPSSRelCnfg             |highLimitPwrPSSRelCnfg    |-9           |-9           |
      |highLimitPwrPSSRelCnfg             |highLimitPwrPSSRelCnfg    |-10           |-10           |
      |lowLimitPwrPSSRelCnfg             |lowLimitPwrPSSRelCnfg    |-15           |-15           |

#######################################################################################################################
  Scenario Outline: highLimitPwrSSSAbsCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitPwrSSSAbsCnfg             |highLimitPwrSSSAbsCnfg    |-120.1           |-120           |
      |highLimitPwrSSSAbsCnfg             |highLimitPwrSSSAbsCnfg    |-120           |-120           |
      |highLimitPwrSSSAbsCnfg             |highLimitPwrSSSAbsCnfg    |-119.99           |-119.99           |
      |highLimitPwrSSSAbsCnfg             |highLimitPwrSSSAbsCnfg    |99.99           |99.99           |
      |highLimitPwrSSSAbsCnfg             |highLimitPwrSSSAbsCnfg    |100             |100           |
      |highLimitPwrSSSAbsCnfg             |highLimitPwrSSSAbsCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: lowLimitPwrSSSAbsCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |lowLimitPwrSSSAbsCnfg             |lowLimitPwrSSSAbsCnfg    |-120.1           |-120           |
      |lowLimitPwrSSSAbsCnfg             |lowLimitPwrSSSAbsCnfg    |-120           |-120           |
      |lowLimitPwrSSSAbsCnfg             |lowLimitPwrSSSAbsCnfg    |-119.99           |-119.99           |
      |lowLimitPwrSSSAbsCnfg             |lowLimitPwrSSSAbsCnfg    |99.99           |99.99           |
      |lowLimitPwrSSSAbsCnfg             |lowLimitPwrSSSAbsCnfg    |100             |100           |
      |lowLimitPwrSSSAbsCnfg             |lowLimitPwrSSSAbsCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: highLimitPwrSSSAbsCnfg lowLimitPwrSSSAbsCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitPwrSSSAbsCnfg             |highLimitPwrSSSAbsCnfg    |22           |22           |
      |lowLimitPwrSSSAbsCnfg             |lowLimitPwrSSSAbsCnfg    |18           |18           |
      |highLimitPwrSSSAbsCnfg             |lowLimitPwrSSSAbsCnfg    |14           |14           |
      |lowLimitPwrSSSAbsCnfg             |highLimitPwrSSSAbsCnfg    |28           |28           |
      |highLimitPwrSSSAbsCnfg             |highLimitPwrSSSAbsCnfg    |22           |22           |
      |lowLimitPwrSSSAbsCnfg             |lowLimitPwrSSSAbsCnfg    |18           |18           |

#######################################################################################################################
  Scenario Outline: highLimitPwrSSSRelCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitPwrSSSRelCnfg             |highLimitPwrSSSRelCnfg    |-150.1           |-150           |
      |highLimitPwrSSSRelCnfg             |highLimitPwrSSSRelCnfg    |-150           |-150           |
      |highLimitPwrSSSRelCnfg             |highLimitPwrSSSRelCnfg    |-99.99           |-99.99           |
      |highLimitPwrSSSRelCnfg             |highLimitPwrSSSRelCnfg    |-0.01           |-0.01           |
      |highLimitPwrSSSRelCnfg             |highLimitPwrSSSRelCnfg    |0             |0           |
      |highLimitPwrSSSRelCnfg             |highLimitPwrSSSRelCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: lowLimitPwrSSSRelCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |lowLimitPwrSSSRelCnfg             |lowLimitPwrSSSRelCnfg    |-150.1           |-150           |
      |lowLimitPwrSSSRelCnfg             |lowLimitPwrSSSRelCnfg    |-150           |-150           |
      |lowLimitPwrSSSRelCnfg             |lowLimitPwrSSSRelCnfg    |-99.99           |-99.99           |
      |lowLimitPwrSSSRelCnfg             |lowLimitPwrSSSRelCnfg    |-0.01           |-0.01           |
      |lowLimitPwrSSSRelCnfg             |lowLimitPwrSSSRelCnfg    |0             |0           |
      |lowLimitPwrSSSRelCnfg             |lowLimitPwrSSSRelCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: highLimitPwrSSSRelCnfg lowLimitPwrSSSRelCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitPwrSSSRelCnfg             |highLimitPwrSSSRelCnfg    |-10           |-10           |
      |lowLimitPwrSSSRelCnfg             |lowLimitPwrSSSRelCnfg    |-15           |-15           |
      |highLimitPwrSSSRelCnfg             |lowLimitPwrSSSRelCnfg    |-24           |-24           |
      |lowLimitPwrSSSRelCnfg             |highLimitPwrSSSRelCnfg    |-9           |-9           |
      |highLimitPwrSSSRelCnfg             |highLimitPwrSSSRelCnfg    |-10           |-10           |
      |lowLimitPwrSSSRelCnfg             |lowLimitPwrSSSRelCnfg    |-15           |-15           |

#######################################################################################################################
  Scenario Outline: highLimitPwrPBCHAbsCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitPwrPBCHAbsCnfg             |highLimitPwrPBCHAbsCnfg    |-120.1           |-120           |
      |highLimitPwrPBCHAbsCnfg             |highLimitPwrPBCHAbsCnfg    |-120           |-120           |
      |highLimitPwrPBCHAbsCnfg             |highLimitPwrPBCHAbsCnfg    |-119.99           |-119.99           |
      |highLimitPwrPBCHAbsCnfg             |highLimitPwrPBCHAbsCnfg    |99.99           |99.99           |
      |highLimitPwrPBCHAbsCnfg             |highLimitPwrPBCHAbsCnfg    |100             |100           |
      |highLimitPwrPBCHAbsCnfg             |highLimitPwrPBCHAbsCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: lowLimitPwrPBCHAbsCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |lowLimitPwrPBCHAbsCnfg             |lowLimitPwrPBCHAbsCnfg    |-120.1           |-120           |
      |lowLimitPwrPBCHAbsCnfg             |lowLimitPwrPBCHAbsCnfg    |-120           |-120           |
      |lowLimitPwrPBCHAbsCnfg             |lowLimitPwrPBCHAbsCnfg    |-119.99           |-119.99           |
      |lowLimitPwrPBCHAbsCnfg             |lowLimitPwrPBCHAbsCnfg    |99.99           |99.99           |
      |lowLimitPwrPBCHAbsCnfg             |lowLimitPwrPBCHAbsCnfg    |100             |100           |
      |lowLimitPwrPBCHAbsCnfg             |lowLimitPwrPBCHAbsCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: highLimitPwrPBCHAbsCnfg lowLimitPwrPBCHAbsCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitPwrPBCHAbsCnfg             |highLimitPwrPBCHAbsCnfg    |22           |22           |
      |lowLimitPwrPBCHAbsCnfg             |lowLimitPwrPBCHAbsCnfg    |18           |18           |
      |highLimitPwrPBCHAbsCnfg             |lowLimitPwrPBCHAbsCnfg    |14           |14           |
      |lowLimitPwrPBCHAbsCnfg             |highLimitPwrPBCHAbsCnfg    |28           |28           |
      |highLimitPwrPBCHAbsCnfg             |highLimitPwrPBCHAbsCnfg    |22           |22           |
      |lowLimitPwrPBCHAbsCnfg             |lowLimitPwrPBCHAbsCnfg    |18           |18           |

#######################################################################################################################
  Scenario Outline: highLimitPwrPBCHRelCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitPwrPBCHRelCnfg             |highLimitPwrPBCHRelCnfg    |-150.1           |-150           |
      |highLimitPwrPBCHRelCnfg             |highLimitPwrPBCHRelCnfg    |-150           |-150           |
      |highLimitPwrPBCHRelCnfg             |highLimitPwrPBCHRelCnfg    |-99.99           |-99.99           |
      |highLimitPwrPBCHRelCnfg             |highLimitPwrPBCHRelCnfg    |-0.01           |-0.01           |
      |highLimitPwrPBCHRelCnfg             |highLimitPwrPBCHRelCnfg    |0             |0           |
      |highLimitPwrPBCHRelCnfg             |highLimitPwrPBCHRelCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: lowLimitPwrPBCHRelCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |lowLimitPwrPBCHRelCnfg             |lowLimitPwrPBCHRelCnfg    |-150.1           |-150           |
      |lowLimitPwrPBCHRelCnfg             |lowLimitPwrPBCHRelCnfg    |-150           |-150           |
      |lowLimitPwrPBCHRelCnfg             |lowLimitPwrPBCHRelCnfg    |-99.99           |-99.99           |
      |lowLimitPwrPBCHRelCnfg             |lowLimitPwrPBCHRelCnfg    |-0.01           |-0.01           |
      |lowLimitPwrPBCHRelCnfg             |lowLimitPwrPBCHRelCnfg    |0             |0           |
      |lowLimitPwrPBCHRelCnfg             |lowLimitPwrPBCHRelCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: highLimitPwrPBCHRelCnfg lowLimitPwrPBCHRelCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitPwrPBCHRelCnfg             |highLimitPwrPBCHRelCnfg    |-10           |-10           |
      |lowLimitPwrPBCHRelCnfg             |lowLimitPwrPBCHRelCnfg    |-15           |-15           |
      |highLimitPwrPBCHRelCnfg             |lowLimitPwrPBCHRelCnfg    |-24           |-24           |
      |lowLimitPwrPBCHRelCnfg             |highLimitPwrPBCHRelCnfg    |-9           |-9           |
      |highLimitPwrPBCHRelCnfg             |highLimitPwrPBCHRelCnfg    |-10           |-10           |
      |lowLimitPwrPBCHRelCnfg             |lowLimitPwrPBCHRelCnfg    |-15           |-15           |

#######################################################################################################################
  Scenario Outline: highLimitPwrSubframeCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitPwrSubframeCnfg             |highLimitPwrSubframeCnfg    |-120.1           |-120           |
      |highLimitPwrSubframeCnfg             |highLimitPwrSubframeCnfg    |-120           |-120           |
      |highLimitPwrSubframeCnfg             |highLimitPwrSubframeCnfg    |-119.99           |-119.99           |
      |highLimitPwrSubframeCnfg             |highLimitPwrSubframeCnfg    |99.99           |99.99           |
      |highLimitPwrSubframeCnfg             |highLimitPwrSubframeCnfg    |100             |100           |
      |highLimitPwrSubframeCnfg             |highLimitPwrSubframeCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: lowLimitPwrSubframeCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |lowLimitPwrSubframeCnfg             |lowLimitPwrSubframeCnfg    |-120.1           |-120           |
      |lowLimitPwrSubframeCnfg             |lowLimitPwrSubframeCnfg    |-120           |-120           |
      |lowLimitPwrSubframeCnfg             |lowLimitPwrSubframeCnfg    |-119.99           |-119.99           |
      |lowLimitPwrSubframeCnfg             |lowLimitPwrSubframeCnfg    |99.99           |99.99           |
      |lowLimitPwrSubframeCnfg             |lowLimitPwrSubframeCnfg    |100             |100           |
      |lowLimitPwrSubframeCnfg             |lowLimitPwrSubframeCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: highLimitPwrSubframeCnfg lowLimitPwrSubframeCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitPwrSubframeCnfg             |highLimitPwrSubframeCnfg    |22           |22           |
      |lowLimitPwrSubframeCnfg             |lowLimitPwrSubframeCnfg    |18           |18           |
      |highLimitPwrSubframeCnfg             |lowLimitPwrSubframeCnfg    |14           |14           |
      |lowLimitPwrSubframeCnfg             |highLimitPwrSubframeCnfg    |28           |28           |
      |highLimitPwrSubframeCnfg             |highLimitPwrSubframeCnfg    |22           |22           |
      |lowLimitPwrSubframeCnfg             |lowLimitPwrSubframeCnfg    |18           |18           |

#######################################################################################################################
  Scenario Outline: highLimitPwrOFDMCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitPwrOFDMCnfg             |highLimitPwrOFDMCnfg    |-120.1           |-120           |
      |highLimitPwrOFDMCnfg             |highLimitPwrOFDMCnfg    |-120           |-120           |
      |highLimitPwrOFDMCnfg             |highLimitPwrOFDMCnfg    |-119.99           |-119.99           |
      |highLimitPwrOFDMCnfg             |highLimitPwrOFDMCnfg    |99.99           |99.99           |
      |highLimitPwrOFDMCnfg             |highLimitPwrOFDMCnfg    |100             |100           |
      |highLimitPwrOFDMCnfg             |highLimitPwrOFDMCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: lowLimitPwrOFDMCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |lowLimitPwrOFDMCnfg             |lowLimitPwrOFDMCnfg    |-120.1           |-120           |
      |lowLimitPwrOFDMCnfg             |lowLimitPwrOFDMCnfg    |-120           |-120           |
      |lowLimitPwrOFDMCnfg             |lowLimitPwrOFDMCnfg    |-119.99           |-119.99           |
      |lowLimitPwrOFDMCnfg             |lowLimitPwrOFDMCnfg    |99.99           |99.99           |
      |lowLimitPwrOFDMCnfg             |lowLimitPwrOFDMCnfg    |100             |100           |
      |lowLimitPwrOFDMCnfg             |lowLimitPwrOFDMCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: highLimitPwrOFDMCnfg lowLimitPwrOFDMCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitPwrOFDMCnfg             |highLimitPwrOFDMCnfg    |22           |22           |
      |lowLimitPwrOFDMCnfg             |lowLimitPwrOFDMCnfg    |18           |18           |
      |highLimitPwrOFDMCnfg             |lowLimitPwrOFDMCnfg    |14           |14           |
      |lowLimitPwrOFDMCnfg             |highLimitPwrOFDMCnfg    |28           |28           |
      |highLimitPwrOFDMCnfg             |highLimitPwrOFDMCnfg    |22           |22           |
      |lowLimitPwrOFDMCnfg             |lowLimitPwrOFDMCnfg    |18           |18           |

#######################################################################################################################
  Scenario Outline: highLimitPwrFrameAVGCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitPwrFrameAVGCnfg             |highLimitPwrFrameAVGCnfg    |-120.1           |-120           |
      |highLimitPwrFrameAVGCnfg             |highLimitPwrFrameAVGCnfg    |-120           |-120           |
      |highLimitPwrFrameAVGCnfg             |highLimitPwrFrameAVGCnfg    |-119.99           |-119.99           |
      |highLimitPwrFrameAVGCnfg             |highLimitPwrFrameAVGCnfg    |99.99           |99.99           |
      |highLimitPwrFrameAVGCnfg             |highLimitPwrFrameAVGCnfg    |100             |100           |
      |highLimitPwrFrameAVGCnfg             |highLimitPwrFrameAVGCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: lowLimitPwrFrameAVGCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |lowLimitPwrFrameAVGCnfg             |lowLimitPwrFrameAVGCnfg    |-120.1           |-120           |
      |lowLimitPwrFrameAVGCnfg             |lowLimitPwrFrameAVGCnfg    |-120           |-120           |
      |lowLimitPwrFrameAVGCnfg             |lowLimitPwrFrameAVGCnfg    |-119.99           |-119.99           |
      |lowLimitPwrFrameAVGCnfg             |lowLimitPwrFrameAVGCnfg    |99.99           |99.99           |
      |lowLimitPwrFrameAVGCnfg             |lowLimitPwrFrameAVGCnfg    |100             |100           |
      |lowLimitPwrFrameAVGCnfg             |lowLimitPwrFrameAVGCnfg    |100.01           |100           |

#######################################################################################################################
  Scenario Outline: highLimitPwrFrameAVGCnfg lowLimitPwrFrameAVGCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitPwrFrameAVGCnfg             |highLimitPwrFrameAVGCnfg    |22           |22           |
      |lowLimitPwrFrameAVGCnfg             |lowLimitPwrFrameAVGCnfg    |18           |18           |
      |highLimitPwrFrameAVGCnfg             |lowLimitPwrFrameAVGCnfg    |14           |14           |
      |lowLimitPwrFrameAVGCnfg             |highLimitPwrFrameAVGCnfg    |28           |28           |
      |highLimitPwrFrameAVGCnfg             |highLimitPwrFrameAVGCnfg    |22           |22           |
      |lowLimitPwrFrameAVGCnfg             |lowLimitPwrFrameAVGCnfg    |18           |18           |

#######################################################################################################################
  Scenario Outline: highLimitTAEMIMOCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitTAEMIMOCnfg             |highLimitTAEMIMOCnfg    |-10000.1           |-10000           |
      |highLimitTAEMIMOCnfg             |highLimitTAEMIMOCnfg    |-10000           |-10000           |
      |highLimitTAEMIMOCnfg             |highLimitTAEMIMOCnfg    |-9999.99           |-9999.99           |
      |highLimitTAEMIMOCnfg             |highLimitTAEMIMOCnfg    |9999.99           |9999.99           |
      |highLimitTAEMIMOCnfg             |highLimitTAEMIMOCnfg    |10000             |10000           |
      |highLimitTAEMIMOCnfg             |highLimitTAEMIMOCnfg    |10000.01           |10000           |

#######################################################################################################################
  Scenario Outline: highLimitCAIntraContCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitCAIntraContCnfg             |highLimitCAIntraContCnfg    |-10000.1           |-10000           |
      |highLimitCAIntraContCnfg             |highLimitCAIntraContCnfg    |-10000           |-10000           |
      |highLimitCAIntraContCnfg             |highLimitCAIntraContCnfg    |-9999.99           |-9999.99           |
      |highLimitCAIntraContCnfg             |highLimitCAIntraContCnfg    |9999.99           |9999.99           |
      |highLimitCAIntraContCnfg             |highLimitCAIntraContCnfg    |10000             |10000           |
      |highLimitCAIntraContCnfg             |highLimitCAIntraContCnfg    |10000.01           |10000           |

#######################################################################################################################
  Scenario Outline: highLimitCAIntraNonCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitCAIntraNonCnfg             |highLimitCAIntraNonCnfg    |-10000.1           |-10000           |
      |highLimitCAIntraNonCnfg             |highLimitCAIntraNonCnfg    |-10000           |-10000           |
      |highLimitCAIntraNonCnfg             |highLimitCAIntraNonCnfg    |-9999.99           |-9999.99           |
      |highLimitCAIntraNonCnfg             |highLimitCAIntraNonCnfg    |9999.99           |9999.99           |
      |highLimitCAIntraNonCnfg             |highLimitCAIntraNonCnfg    |10000             |10000           |
      |highLimitCAIntraNonCnfg             |highLimitCAIntraNonCnfg    |10000.01           |10000           |

#######################################################################################################################
  Scenario Outline: highLimitCAInterBandCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitCAInterBandCnfg             |highLimitCAInterBandCnfg    |-10000.1           |-10000           |
      |highLimitCAInterBandCnfg             |highLimitCAInterBandCnfg    |-10000           |-10000           |
      |highLimitCAInterBandCnfg             |highLimitCAInterBandCnfg    |-9999.99           |-9999.99           |
      |highLimitCAInterBandCnfg             |highLimitCAInterBandCnfg    |9999.99           |9999.99           |
      |highLimitCAInterBandCnfg             |highLimitCAInterBandCnfg    |10000             |10000           |
      |highLimitCAInterBandCnfg             |highLimitCAInterBandCnfg    |10000.01           |10000           |

#######################################################################################################################
  Scenario Outline: highLimitTimeErrCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitTimeErrCnfg             |highLimitTimeErrCnfg    |-10000.1           |-10000           |
      |highLimitTimeErrCnfg             |highLimitTimeErrCnfg    |-10000           |-10000           |
      |highLimitTimeErrCnfg             |highLimitTimeErrCnfg    |-9999.99           |-9999.99           |
      |highLimitTimeErrCnfg             |highLimitTimeErrCnfg    |9999.99           |9999.99           |
      |highLimitTimeErrCnfg             |highLimitTimeErrCnfg    |10000             |10000           |
      |highLimitTimeErrCnfg             |highLimitTimeErrCnfg    |10000.01           |10000           |

#######################################################################################################################
  Scenario Outline: lowLimitTimeErrCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |lowLimitTimeErrCnfg             |lowLimitTimeErrCnfg    |-10000.1           |-10000           |
      |lowLimitTimeErrCnfg             |lowLimitTimeErrCnfg    |-10000           |-10000           |
      |lowLimitTimeErrCnfg             |lowLimitTimeErrCnfg    |-9999.99           |-9999.99           |
      |lowLimitTimeErrCnfg             |lowLimitTimeErrCnfg    |9999.99           |9999.99           |
      |lowLimitTimeErrCnfg             |lowLimitTimeErrCnfg    |10000             |10000           |
      |lowLimitTimeErrCnfg             |lowLimitTimeErrCnfg    |10000.01           |10000           |

#######################################################################################################################
  Scenario Outline: highLimitTimeErrCnfg lowLimitTimeErrCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitTimeErrCnfg             |highLimitTimeErrCnfg    |2           |2           |
      |lowLimitTimeErrCnfg             |lowLimitTimeErrCnfg    |-2           |-2           |
      |highLimitTimeErrCnfg             |lowLimitTimeErrCnfg    |-5           |-5           |
      |lowLimitTimeErrCnfg             |highLimitTimeErrCnfg    |4           |4           |
      |highLimitTimeErrCnfg             |highLimitTimeErrCnfg    |2             |2           |
      |lowLimitTimeErrCnfg             |lowLimitTimeErrCnfg    |-2           |-2           |

#######################################################################################################################
  Scenario Outline: highLimitIQOriOffsetCnfg test
    When I change <id> value to <inputValue>.
    Then I make sure floating that <targetid> value is equal to <expectValue>.

    Examples:
      |id                                 |targetid   |inputValue   |expectValue    |
      |highLimitIQOriOffsetCnfg             |highLimitIQOriOffsetCnfg    |-100.1           |-100           |
      |highLimitIQOriOffsetCnfg             |highLimitIQOriOffsetCnfg    |-100           |-100           |
      |highLimitIQOriOffsetCnfg             |highLimitIQOriOffsetCnfg    |-99.99           |-99.99           |
      |highLimitIQOriOffsetCnfg             |highLimitIQOriOffsetCnfg    |-0.01           |-0.01           |
      |highLimitIQOriOffsetCnfg             |highLimitIQOriOffsetCnfg    |0             |0           |
      |highLimitIQOriOffsetCnfg             |highLimitIQOriOffsetCnfg    |0.01           |0           |

#######################################################################################################################
  Scenario Outline: measurementModeCnfg test
    When I change <id> value to <inputValue>.
    When I want to delay at 5.
    Then I make sure that <id> value is equal to <inputValue>.
    Given I have connected device by ssh to DEV_IP
    Then I check alive ui "ca5g"

    Examples:
      |id                       |inputValue   |
      |measurementModeCnfg      |spectrum    |
      |measurementModeCnfg      |channelPower    |
      |measurementModeCnfg      |occupiedBW    |
      |measurementModeCnfg      |spectrumEmissionMask    |
      |measurementModeCnfg      |adjacentChannelPower    |
      |measurementModeCnfg      |multiAdjacentChannelPower    |
      |measurementModeCnfg      |spuriousEmissionMask    |
      |measurementModeCnfg      |powerVSTimeFrame    |
      |measurementModeCnfg      |powerVSTimeSlot    |
      |measurementModeCnfg      |constellation    |
      |measurementModeCnfg      |dataChannel    |
      |measurementModeCnfg      |controlChannel    |
      |measurementModeCnfg      |subframe    |
      |measurementModeCnfg      |frame    |
      |measurementModeCnfg      |timeAlignmentError    |
      |measurementModeCnfg      |dataAllocationMap    |
      |measurementModeCnfg      |carrierAggregation    |
      |measurementModeCnfg      |otaChannelScanner    |
      |measurementModeCnfg      |otaIDScanner    |
      |measurementModeCnfg      |otaControlChannel    |
      |measurementModeCnfg      |otaDatagram    |
      |measurementModeCnfg      |otaMultipathProfile    |
      |measurementModeCnfg      |otaRouteMap    |
      |measurementModeCnfg      |powerStatisticsCCDF    |
      |measurementModeCnfg      |spectrum    |
      |measurementModeCnfg      |channelPower    |
      |measurementModeCnfg      |occupiedBW    |
      |measurementModeCnfg      |spectrumEmissionMask    |
      |measurementModeCnfg      |adjacentChannelPower    |
      |measurementModeCnfg      |multiAdjacentChannelPower    |
      |measurementModeCnfg      |spuriousEmissionMask    |
      |measurementModeCnfg      |powerVSTimeFrame    |
      |measurementModeCnfg      |powerVSTimeSlot    |
      |measurementModeCnfg      |constellation    |
      |measurementModeCnfg      |dataChannel    |
      |measurementModeCnfg      |controlChannel    |
      |measurementModeCnfg      |subframe    |
      |measurementModeCnfg      |frame    |
      |measurementModeCnfg      |timeAlignmentError    |
      |measurementModeCnfg      |dataAllocationMap    |
      |measurementModeCnfg      |carrierAggregation    |
      |measurementModeCnfg      |otaChannelScanner    |
      |measurementModeCnfg      |otaIDScanner    |
      |measurementModeCnfg      |otaControlChannel    |
      |measurementModeCnfg      |otaDatagram    |
      |measurementModeCnfg      |otaMultipathProfile    |
      |measurementModeCnfg      |otaRouteMap    |
      |measurementModeCnfg      |powerStatisticsCCDF    |
