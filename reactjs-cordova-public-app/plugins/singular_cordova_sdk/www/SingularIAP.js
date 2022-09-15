function SingularIAP(product) {
    this.ppc = product.currency;
    this.r = Number(product?.price?.replace(/[^0-9.-]+/g,""));
    this.is_revenue_event = true;

    if (product?.transaction?.type == 'android-playstore'){
        this.ptr = product?.transaction?.receipt;
        this.receipt = product?.transaction?.receipt;
        this.receipt_signature = product?.transaction?.signature;
    }

    if (product?.transaction?.type == 'ios-appstore'){
        this.ptr = product?.transaction?.appStoreReceipt;
        this.pti = product?.transaction?.id;
        this.pk = product?.id;
    }
}

module.exports = SingularIAP;
