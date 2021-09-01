const { expect } = require('chai');
const { Contract } = require('ethers');
const { ethers } = require('hardhat');

const MAX_UINT256_STRING_LENGTH = 78;
function randomUint(digits) {
    if (!digits) {
        digits = Math.floor(Math.random() * (MAX_UINT256_STRING_LENGTH - 1));
    }
    return BigInt(
        Array(digits)
            .fill()
            .map(() => Math.floor(Math.random() * 10).toString())
            .join(''),
    ).toString();
}

const NUM_SAMPLES = Number.parseInt(process.env.NUM_SAMPLES || '100');

describe('LibUintToString.toString', function () {
    let testContract;
    before(async function () {
        const TestUintToString = await ethers.getContractFactory('TestUintToString');
        testContract = await TestUintToString.deploy();
        await testContract.deployed();
    });
    it('Should convert 0 to "0"', async function () {
        const result = await testContract.testToString(0);
        // console.log(`gas cost: ${result.gasCost}`);
        expect(result.str).to.equal('0');
    });
    it('Should correctly convert type(uint256).max', async function () {
        const maxUint256 = 2n ** 256n - 1n;
        const result = await testContract.testToString(maxUint256.toString());
        // console.log(`gas cost: ${result.gasCost}`);
        expect(result.str).to.equal(maxUint256.toString());
    });
    it('Should correctly convert a random uint256 to a string', async function () {
        for (let i = 0; i < NUM_SAMPLES; i++) {
            const uint = randomUint();
            const result = await testContract.testToString(uint);
            // console.log(uint);
            // console.log(`gas cost: ${result.gasCost}`);
            expect(result.str).to.equal(uint);
        }
    });
    it.skip('Gas benchmark', async function () {
        for (let digits = 1; digits < MAX_UINT256_STRING_LENGTH; digits++) {
            console.log(`================== ${digits} digit integers ==================`);
            let testAverage = 0;
            let baselineAverage = 0;
            for (let i = 0; i < NUM_SAMPLES; i++) {
                const uint = randomUint(digits);
                const testResult = await testContract.testToString(uint);
                testAverage += testResult.gasCost.toNumber();
                const baselineResult = await testContract.baselineToString(uint);
                baselineAverage += baselineResult.gasCost.toNumber();
            }
            testAverage /= NUM_SAMPLES;
            baselineAverage /= NUM_SAMPLES;
            console.log(`Test average: ${testAverage} gas`);
            console.log(`Baseline average: ${baselineAverage} gas`);
            console.log(
                `    ${testAverage < baselineAverage ? '-' : '+'}${
                    (Math.abs(baselineAverage - testAverage) / baselineAverage) * 100
                }%`,
            );
        }
    });
});
