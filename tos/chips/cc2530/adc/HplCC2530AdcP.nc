/*
 * Copyright (c) 2013 Northwestern Polytechnical University, China
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 *
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 *
 * - Neither the name of the copyright holders nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/*
 * @author Qiu Ying <qiuying@mail.nwpu.edu.cn>
 * @date 2013/04/07
 * @description
 */

#include "cc2530.h"
#include "cc2530adc.h"

module HplCC2530AdcP {
    provides interface HplCC2530Adc;
}
implementation {
    async command void HplCC2530Adc.singleConversion(uint8_t settings) {
        ADCCON3 = settings;
    }

    async command void HplCC2530Adc.sequenceSetup(uint8_t settings) {
        ADCCON2 = settings;
    }

    /* starting the ADC in continuous conversion mode */
    async command void HplCC2530Adc.sampleContinuous() {
        ADCCON1 &= ~0x30;
        ADCCON1 |= 0x10;
    }

    /* stopping the ADC in continuous mode (and setting the ADC to be
       started manually by sampleSingle()) */
    async command void HplCC2530Adc.stop() {
        ADCCON1 |= 0x30;
    }

    /* initiating a single sample in single-conversion mode (ADCCON1.STSEL = 11). */
    async command void HplCC2530Adc.sampleSingle() {
        call HplCC2530Adc.stop();
        ADCCON1 |= 0x40;
    }

    /* configuring the ADC to be started from T1 channel 0.
       (T1 ch 0 must be in compare mode!!) */
    async command void HplCC2530Adc.triggerFromTimer1() {
        call HplCC2530Adc.stop();
        ADCCON1 &= ~0x10;
    }

    /* Expression indicating whether a conversion is finished or not. */
    async command uint8_t HplCC2530Adc.sampleReady() {
        return (ADCCON1 & 0x80);
    }

    /* setting a channel as input of the ADC */
    async command void HplCC2530Adc.enableChannel(uint8_t ch) {
        ADCCFG |=  (0x01<<ch);
    }

    /* clearing a channel as input of the ADC */
    async command void HplCC2530Adc.disableChannel(uint8_t ch) {
        ADCCFG &= ~(0x01<<ch);
    }

    async command uint16_t HplCC2530Adc.data() {
        uint16_t value;
        value = ADCL >> 2;
        value |= ((uint16_t)ADCH) << 6;
        return value;
    }
    
}
