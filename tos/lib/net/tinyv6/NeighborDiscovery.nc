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
 * NeighborDiscovery
 *
 * @author Qiu Ying <qiuying@mail.nwpu.edu.cn>
 * @date 2012/10/06
 * @description
 */

interface NeighborDiscovery {
    /*
     * in6addr: neighor's link local address
     * pamaddr: pointer to neighbor's AM address
     * return: SUCCESS or FAIL
     */
	command error_t getLinkLayerAddress(nx_struct t6_addr in6addr, am_addr_t *pamaddr);

    /*
     * amaddr: neighbor's AM address
     * pin6addr: pointer to neighor's link local address
     * return: SUCCESS or FAIL
     */
	command error_t getIp6Address(am_addr_t amaddr, nx_struct t6_addr *pin6addr);

    /*
     * Add item to neighbor table
     *
     * amaddr: neighbor's AM address
     * pin6addr: neighor's link local address
     * return: SUCCESS or FAIL
     */
	command error_t addNeighbor(am_addr_t amaddr, nx_struct t6_addr in6addr);
}
