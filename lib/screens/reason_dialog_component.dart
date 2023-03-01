import 'package:dsr_admin/main.dart';
import 'package:dsr_admin/model/Prescription_Model.dart';
import 'package:dsr_admin/utils/Colors.dart';
import 'package:dsr_admin/utils/Common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class ReasonDialog extends StatefulWidget {
  final PrescriptionModel? data;
  final VoidCallback? voidCallBack;

  ReasonDialog({this.data, this.voidCallBack});

  @override
  _ReasonDialogState createState() => _ReasonDialogState();
}

class _ReasonDialogState extends State<ReasonDialog> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController _textFieldReason = TextEditingController();

  Future<void> _handleSubmit() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      hideKeyboard(context);

      PrescriptionModel data = PrescriptionModel();
      data.diseaseData = widget.data!.diseaseData;
      data.id = widget.data!.id.validate();
      data.url = widget.data!.url.validate();
      data.path = widget.data!.path.validate();
      data.uid = widget.data!.uid.validate();
      data.reason = _textFieldReason.text.validate();
      data.createdAt = widget.data!.createdAt.validate();
      data.updatedAt = DateTime.now().toString();
      data.status = '2';

      appStore.setLoading(true);

      await prescriptionService.updatePrescription(id: widget.data!.id.validate(), data: data).then((value) {
        toast('${widget.data!.diseaseData!.name.validate()} is rejected successfully');
        finish(context);
        finish(context);
        widget.voidCallBack?.call();
      }).catchError((e) {
        toast(e.toString());
      });

      appStore.setLoading(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: context.width(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: AppTextField(
                      controller: _textFieldReason,
                      textFieldType: TextFieldType.MULTILINE,
                      decoration: inputDecoration(context, labelText: 'Enter Reason'),
                      minLines: 4,
                      validator: (value) {
                        if (value!.isEmpty) return 'This Field is required';
                        return null;
                      },
                      maxLines: 10,
                    ),
                  ),
                  16.height,
                  AppButton(
                    color: primaryColor,
                    height: 40,
                    text: 'Submit',
                    textStyle: boldTextStyle(color: Colors.white),
                    width: context.width() - context.navigationBarHeight,
                    onTap: () {
                      _handleSubmit();
                    },
                  ),
                ],
              ).paddingAll(16)
            ],
          ),
        ),
        Observer(
          builder: (context) => Loader().withSize(height: 80, width: 80).visible(appStore.isLoading),
        )
      ],
    );
  }
}
